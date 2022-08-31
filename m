Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39F25A84C4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbiHaRvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiHaRv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:51:29 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0293BB938;
        Wed, 31 Aug 2022 10:51:27 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id fa2so7162413pjb.2;
        Wed, 31 Aug 2022 10:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=HeHd13NUasJVCk4KgKhrFLwhTEXtxTOChOcy1/oX1Kk=;
        b=T3LTxnDRIVReJHwofzw8MZ2qvXfgMT4g2ghnvIhL51ORKruE4CxWgyIGCEuhsrqJGs
         71nm++fCd3TSlgdZWfe8X5JelIqfT6FhGPivegZmZ9te5yfzyy8hp12KSxl2rgPnvFWg
         lq+Um47WnFZ0ZA/pLUW9aFGS1PWKIn+L9RQSYQ0wFJXuSbbIvoQQhMX09g5xcgVFPn7Y
         rvvANWn6DoJb1jxRagdXdjHJbZEm0FkR6kAKh61Fe4wAGKfHYTvdXHNlZgus30qhvZCc
         P0iofwI3avwqlQmh4hFasO3tYD8P6/+cY3XrQNIdjji7xY3r3aThxJAzMSRqrYknUu9a
         6c+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=HeHd13NUasJVCk4KgKhrFLwhTEXtxTOChOcy1/oX1Kk=;
        b=pna58Aw7/7wb1pWtxC/qyjpRR7IMmwCAw+netoYACZ4kTEecXBKWZqXEXSX3NAYc0C
         wZrgUPUK8ehtU+ePV5MZ1ZhNV/2HPZwjF1k8b6AlOXeH4CzTbCRDV2kE9eay12N9q8VM
         yFpXbLZL0BH3D1y/AFbnpfbFyU4gXM09OYL6Pwp22W52Z4hqIMb373BbsADEu0A545A7
         rjy8T7f0ZL7CmNaDcxRc+Ivpehxd90gj1HBz/UZgE16CE7LdaeMQBNaT1Wh1P1uC3LaB
         z5GChAmWDBqlwXRDX0DpWcdfojOKLD9zVkTEBYK6DXuZHNc776EVn1ZFXBcRIM9/v9e9
         LyxQ==
X-Gm-Message-State: ACgBeo2a/IvfF7mLaiTp2KRaKpo8S/eBVrVt+f81ElkZowVtrVSVc5Q6
        aQrbuciPiCqQhHaTNuXZhUQ=
X-Google-Smtp-Source: AA6agR5HBd4CNH6zTJ8+Z3CX9INI+OIwMpJqpGsYZjR7qeZm/8PiyItn0SSCIb5xClMyuzkKaycn7Q==
X-Received: by 2002:a17:903:187:b0:175:4e37:c294 with SMTP id z7-20020a170903018700b001754e37c294mr2271991plg.129.1661968287105;
        Wed, 31 Aug 2022 10:51:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 96-20020a17090a0fe900b001f54fa41242sm1558355pjz.42.2022.08.31.10.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 10:51:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7bf33aaa-11d3-2ff2-8c32-70e11340a3a9@roeck-us.net>
Date:   Wed, 31 Aug 2022 10:51:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/3] usb: typec: tcpm: Add callbacks to mitigate
 wakeups due to contaminant
Content-Language: en-US
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Badhri Jagan Sridharan <badhri@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
References: <20220831001555.285081-1-badhri@google.com>
 <Yw90JmdIxg/YdUYH@kuha.fi.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <Yw90JmdIxg/YdUYH@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/22 07:45, Heikki Krogerus wrote:
> Hi Badhri,
> 
> On Tue, Aug 30, 2022 at 05:15:53PM -0700, Badhri Jagan Sridharan wrote:
>> On some of the TCPC implementations, when the Type-C port is exposed
>> to contaminants, such as water, TCPC stops toggling while reporting OPEN
>> either by the time TCPM reads CC pin status or during CC debounce
>> window. This causes TCPM to be stuck in TOGGLING state. If TCPM is made
>> to restart toggling, the behavior recurs causing redundant CPU wakeups
>> till the USB-C port is free of contaminant.
>>
>> [206199.287817] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
>> [206199.640337] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
>> [206199.985789] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
>> ...
>>
>> To mitigate redundant TCPM wakeups, TCPCs which do have the needed hardware
>> can implement the check_contaminant callback which is invoked by TCPM
>> to evaluate for presence of contaminant. Lower level TCPC driver can
>> restart toggling through TCPM_PORT_CLEAN event when the driver detects
>> that USB-C port is free of contaminant. check_contaminant callback also passes
>> the disconnect_while_debounce flag which when true denotes that the CC pins
>> transitioned to OPEN state during the CC debounce window.
> 
> I'm a little bit concerned about the size of the state machine. I
> think this is a special case that at least in the beginning only the
> Maxim port controller can support, but it's still mixed into the
> "generic" state machine.
> 
> How about if we just add "run_state_machine" callback for the port
> controller drivers so they can handle this kind of special cases on
> their own - they can then also add custom states?
> 

Same concern here. I would very much prefer an approach as suggested below,
especially since the changes around the added disconnect_while_debounce flag
are extensive and difficult to verify.

Thanks,
Guenter

> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 904c7b4ce2f0c..91c22945ba258 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4858,9 +4858,11 @@ static void run_state_machine(struct tcpm_port *port)
>                  tcpm_set_state(port, port->pwr_role == TYPEC_SOURCE ? SRC_READY : SNK_READY, 0);
>                  break;
>          default:
> -               WARN(1, "Unexpected port state %d\n", port->state);
>                  break;
>          }
> +
> +       if (port->tcpc->run_state_machine)
> +               port->tcpc->run_state_machine(port->tcpc);
>   }
>   
>   static void tcpm_state_machine_work(struct kthread_work *work)
> 
> thanks,
> 

