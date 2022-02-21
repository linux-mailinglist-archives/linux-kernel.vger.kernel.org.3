Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804FF4BEB50
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbiBUTmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 14:42:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbiBUTlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 14:41:51 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722B322B02
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 11:41:25 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id s5so12007258oic.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 11:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WCBQPRAXNKEOqzap7VzxRpf2OcOGWxCXupmF+QqH0S4=;
        b=O1R9sTehWUO2FhfEhPLXFpuRRGqs/4WmmT9xIlNb2dZMdG7/haGYG3VL2aLpjbZsVZ
         scnGpQJ9Fk7D+AWCZ+w6mqepFjaGSHRSRXJHO5+atd3kI9ipJdSTnC5aEHjC7+XVV/WM
         qQKeVkCM66N+2oi9vJoEw1aBldeGQ1z/p+JaGHGxuvBqhdhoWpRpvMbJaTMHhOAruoFF
         tvnW0MvTycN2WYoeqtj3I09TAOU489NJ1JmMqmSXEyWIg4rVCxaV0OqtwsVKx76q9vQv
         KcHRPMDuPaCiz4Gjc0DT+mmxtG8UxlpFJlHcJrl5ZVDTp5R75gRZ4+aN5cltMIUvY0mK
         qLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WCBQPRAXNKEOqzap7VzxRpf2OcOGWxCXupmF+QqH0S4=;
        b=GvKa+8fi7rIQLyUL3Hv1bQkbOEQiJfwn/08toXIA0plwbRzHT6gwrMtxHB4Rm2MDIh
         gwAhL8nBYbxZ9jhhncwNOLMWRCRZrGfmqbKJA3FZwBPEDrVz+6thRaguWRpwqKbzTPFF
         L+VwZxqpO+onzTaBYian70eT9vVsXg0Qzkl7Q2vTPhS2nR5GHZ/KtyDuWb5/grNHmLgZ
         TZHz6iQxxwNyDy/o7Q5Wps8CWWcm/sU3Mhg0RS2iD/UMUQnar/a8IcGKCwAis7IxozBz
         ujxgvb9l9NuIPaVjL/iHfgq5jKB8lzUVhd0ieiNrVqi5hiTGcH6Ra39BiDXB2/zCtvYP
         LDGQ==
X-Gm-Message-State: AOAM531CKr1O9Oqvs9jiiYo4L+JBv1VpmlqedwYzXdIUccU/UIo6Q8c0
        9rJu4DXTwVtlAi40bQWGcrM1csF6nus=
X-Google-Smtp-Source: ABdhPJyY3RwwLjtVarsQbG1GDAZuK+UWddBx+8ANkuGv/PX2m0IBeVPkij3YJ16Z2iJ3BHsdQ/JWAg==
X-Received: by 2002:a05:6808:30a7:b0:2d5:2957:f98e with SMTP id bl39-20020a05680830a700b002d52957f98emr283339oib.183.1645472484838;
        Mon, 21 Feb 2022 11:41:24 -0800 (PST)
Received: from [192.168.1.103] (cpe-24-31-246-181.kc.res.rr.com. [24.31.246.181])
        by smtp.gmail.com with ESMTPSA id b16sm4801662oti.69.2022.02.21.11.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 11:41:23 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <636080dd-ab8d-a572-0f81-5f72b14ec1e4@lwfinger.net>
Date:   Mon, 21 Feb 2022 13:41:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/3] staging: r8188eu: remove 5 GHz channels from
 ch_freq_map
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220220154847.7521-1-straube.linux@gmail.com>
 <20220220154847.7521-2-straube.linux@gmail.com> <YhPIVFmStJOMI0QZ@kroah.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <YhPIVFmStJOMI0QZ@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/22 11:13, Greg KH wrote:
> On Sun, Feb 20, 2022 at 04:48:45PM +0100, Michael Straube wrote:
>> This driver is for chips that operate only in the 2.4 GHz band.
> 
> How do we know that?
> 
> thanks,
Realtek 
(https://www.realtek.com/en/products/communications-network-ics/item/rtl8188eus) 
states the following:

"The Realtek RTL8188EUS is an 802.11bgn 2.4G single-chip that integrates 
Wireless LAN (WLAN) and a network USB interface (USB 1.0/1.1/2.0 compatible) 
controller. It combines a WLAN MAC, a 1T1R capable WLAN baseband, and WLAN RF in 
a single chip. The RTL8188EUS provides a complete solution for high-throughput 
performance and low power consumption integrated wireless LAN devices."

The reason there are 5G snippets in the driver is because Realtek uses the base 
code to generate drivers for other chip families such as RTL8192DU that have 
radios for both 2.4 and 5G bands. The RTL81288EU and variants have only a single 
radio.

Larry

