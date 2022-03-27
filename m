Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB124E89C6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 21:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbiC0TjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 15:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiC0TjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 15:39:05 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0124111A13;
        Sun, 27 Mar 2022 12:37:25 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id gi14so10424700qvb.0;
        Sun, 27 Mar 2022 12:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3LGWRyBg498oI15siqEI2qDGC/+DOtozsBR92XCmBsU=;
        b=HvR2BdqDuXoDn7s/RJaxGRdDiQ8s7ibNyBlLGVT/2mRnuxbocB5kCwWbn2XrfkDj0e
         UvRO7GCfe7sm/iFJj4PUgMeewwoGk6cYkvL1Z2LliGL7WOuct7Fw2Kp1bvEXKzNrKbwS
         eRtSqWyihkatQCxMYRbgo8DULW6mJFFXMkYNdzkt2x+5jOS7xR+xY9yZlQVXls76RSlE
         DrzxirTZJmfhMgWjnjL11ZjCLqQZ6/i7eHiPsd/3uaN7BJs+00drEf6T/AzR/sL25hGw
         dnxAVLacJ1154l4zbfkGFZV3WrphXSO0LXgKIJ76J/funtKRFnPWYzEv6wWQNe+w/bzd
         LNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3LGWRyBg498oI15siqEI2qDGC/+DOtozsBR92XCmBsU=;
        b=FV5zSebuJ1WQz4D7P13NwNAJbbMmHITd+oIBYfC7MVpAQykGJ/WwMJRyXXQgCgBeX9
         KF1KVXGtL0BQ5kNUumF49yo7qxULLqcBtnCw80sBkFgDLcrFsNe8lQ0bwSTd5WQpsDGv
         f/GjxT9SImRmV7zU5qfULMwMFDZx2lgJI4Z+OmRdnFZBcGLVGFbcspDpJvQqKd7/h0U8
         sQY6idRU9ZMyNtPSMuLM7Lu1RNLmJXrUKrmOd6s1zYIPT/vPVWiGfS4ryFVIPIjUapkD
         QvP4CJdEDLkja/gy/72tZwPe4eTFZJTmfMv5aw26OuXiOPfb1J+EEk3eRDetMVCnEKWe
         cU5A==
X-Gm-Message-State: AOAM532Jqsqa2HfX9aKSw8GvO7TEM1GVR8sqUrxvIjKVgxiHgX76YeW0
        7D/qcwdtMFqaTry8U9yM+10=
X-Google-Smtp-Source: ABdhPJxd6tqj7Og+iyIogF+nY04/PBPZLgwZ92dFQF0iQiPdoq9V/v5yEytWmy8V14oOdtBm7HkfIQ==
X-Received: by 2002:ad4:5dec:0:b0:441:5ffb:450e with SMTP id jn12-20020ad45dec000000b004415ffb450emr18123790qvb.28.1648409845172;
        Sun, 27 Mar 2022 12:37:25 -0700 (PDT)
Received: from [10.4.10.38] (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id r21-20020a37a815000000b0067d15afb9ebsm7188902qke.90.2022.03.27.12.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 12:37:24 -0700 (PDT)
Message-ID: <88b18cf2-1fa6-ec0b-7ff1-bbc2ffe0d235@gmail.com>
Date:   Sun, 27 Mar 2022 15:37:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v1 12/12] ARM: imxrt_defconfig: Add i.MXRT1170
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>, linux-imx@nxp.com
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com, stefan@agner.ch,
        linus.walleij@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, abel.vesa@nxp.com, dev@lynxeye.de,
        marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        leoyang.li@nxp.com, sebastian.reichel@collabora.com,
        cniedermaier@dh-electronics.com, clin@suse.com,
        giulio.benetti@benettiengineering.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
References: <20220326144313.673549-1-Mr.Bossman075@gmail.com>
 <20220326144313.673549-13-Mr.Bossman075@gmail.com>
 <0ed1a650-d3e3-6ee1-05db-b3760b3cd245@kernel.org>
From:   Jesse Taube <mr.bossman075@gmail.com>
In-Reply-To: <0ed1a650-d3e3-6ee1-05db-b3760b3cd245@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/22 15:23, Krzysztof Kozlowski wrote:
> On 26/03/2022 15:43, Jesse Taube wrote:
>> Add i.MXRT1170 pinctrl, clocks and USB to imxrt_defconfig.
> 
> You add many more i.IMX unrelated functions, like USB gadgets. Please
> explain in commit msg why do you need them.
CONFIG_USB_CONFIGFS selects them because it has OTG support.
I used CONFIG_USB_MASS_STORAGE to test.
I can remove them.
> 
> Best regards,
> Krzysztof
