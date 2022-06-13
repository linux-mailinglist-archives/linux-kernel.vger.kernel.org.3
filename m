Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492AD54A2CE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 01:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbiFMXe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 19:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236672AbiFMXeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 19:34:17 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E23326C8;
        Mon, 13 Jun 2022 16:34:16 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id gd1so7024286pjb.2;
        Mon, 13 Jun 2022 16:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3qAuC1Xx5DZSiCFURmRIjG5OoOgJLKkn2IidFANv/0A=;
        b=Bicphq+Rx/9WWO89rnGH1fubGsFp9bvxKEvZZ97NxPWFwgMhW/fF9eEDYa4og0uxd/
         fIHQ9k6CImFVxuokD/oR6AB9uocXJscd2JfB65UVeJUmLElAflX/fiMmRgWfOj9A/Qqx
         KA9eaPDto/ZaC5v1kKfG5tMsfytyCpEhoMs75aBvF41S7RRh4CBmtcXY8xDeaVZLrP6x
         j5fGxmlmG2hxyfWZ8YIgYwspMKeUaaEdse0WcSrvhI6vyas532OL9PiheSDzsBvCWEao
         mqaQv6iwb/xeXs5/E0JcSwVbwmslLcceM0RLHTGDslbZZgU7jcTE26IWKVEx/CxoKDdD
         zPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3qAuC1Xx5DZSiCFURmRIjG5OoOgJLKkn2IidFANv/0A=;
        b=wr6IVUYtW8WuGpdvRpShG3Frn8aT0Z4Sj/yRO9iAQgbmqAY+JP7bK5DckQIw4KjL9Q
         k1WprRSbFvE+4GR8jOV1yIQN6zkm7+B0DGWbZy2wBs+Pd6M35uj1LMYbFfYJgQAKUbvu
         NPcKMddM6QbIoKb5mxHulzUpgkNxYhUxtpj6ThDL/4VbJFH5206MZ4ewkbgiLPH3+6zx
         ip6SN2jzN6gQPBo0kgGeYaCLROpo1TeYffURFcgDJrdVQA8jFSEhFUmr2yMsI5QbICDL
         qD0oGTrgno+YEEBx1J0JuQaBHJ9SrbIVOD99OjiZaGZlG2L3c2jxTNW1dxq4w/FkRjmf
         uuxQ==
X-Gm-Message-State: AJIora8L4lQkcjlOUtr0loU+jcB1q67EIhRsxhS5oKO4LBQDZf4E7k08
        xDNKWnBuRS32+UHxb7rJ5qw=
X-Google-Smtp-Source: AGRyM1sLL3r1ikyRi4lWU26wXr4ebFo6aJAaPnp6FdoB4QXln7VTpaXoaDBQK+JbVVW42+xaLAmlkQ==
X-Received: by 2002:a17:902:e88e:b0:163:ee82:ffb with SMTP id w14-20020a170902e88e00b00163ee820ffbmr1741929plg.142.1655163255790;
        Mon, 13 Jun 2022 16:34:15 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id q2-20020a170902f78200b00164ade949adsm5721247pln.79.2022.06.13.16.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 16:34:15 -0700 (PDT)
Message-ID: <d18e93a0-f2d7-81c6-56e8-9dfbc6f14383@gmail.com>
Date:   Mon, 13 Jun 2022 16:34:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] ARM: dts: bcm2711-rpi-4-b: Use aliases to set custom MMC
 device index
Content-Language: en-US
To:     Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
        Peter Robinson <pbrobinson@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        gkrzysztof.kozlowski+dt@linaro.org, gnsaenz@kernel.org,
        grobh+dt@kernel.org, nsaenz@kernel.org, stefan.wahren@i2se.com
References: <20220608123233.13439-1-ariel.dalessandro@collabora.com>
 <CALeDE9PR80qS63wwAKB-hENWbEj1xNHj+k81tyWkPPfZ0TS8Pw@mail.gmail.com>
 <f83690bb-5513-db87-2d97-7cbd981aa0f7@collabora.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <f83690bb-5513-db87-2d97-7cbd981aa0f7@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/22 05:46, Ariel D'Alessandro wrote:
> Hi Peter,
> 
> On 6/12/22 17:38, Peter Robinson wrote:
>> On Wed, Jun 8, 2022 at 1:35 PM Ariel D'Alessandro
>> <ariel.dalessandro@collabora.com> wrote:
>>>
>>> Add MMC aliases to ensure that the /dev/mmcblk ID for SD card won't
>>> change depending on the probe order of the MMC drivers.
>>
>> Is  the bcm2711-rpi.dtsi a better place for it given there's other
>> aliases there and it will be consistent across variations?
> 
> Yes, indeed, it makes sense moving it to bcm2711-rpi.dtsi
> 
> The other board what will be affected by this alias is the Raspberry Pi
> Compute Module 4 IO Board, on which emmc2 is the eMMC. However, the
> alias makes sense, to have that as the first mmc device.
> 
> Maybe we can add the alias as follows?
> 
>      mmc0 = &emmc2;  /* mmcblk0 for eMMC/SD */

You have made a typo on the bcm-kernel-feedback-list meaning that this 
won't reach the patchwork instance I use to manage and apply patches, 
can you please fix that up for your v2? Thanks!
-- 
Florian
