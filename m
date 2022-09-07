Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0668D5B0508
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiIGNTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiIGNTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:19:03 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC8F786C5;
        Wed,  7 Sep 2022 06:19:01 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id y3so30373540ejc.1;
        Wed, 07 Sep 2022 06:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=hGL47AsvkQpFBjqI3QRxxpdbSPmI5cqc00bOybuXXDs=;
        b=GNDQ72+jqEwY24a76iS/Jxduk/Rn8WcAJOtWmIp90Ln3228OhP1TgkIyk+ZllXTtjr
         29ZE1xTzqjSoE9t+6OvlZG14WUc80Cdzr18eviAyEQBjV1nJ50kxwAJpb34jBpZmli3S
         xtot2k1Z0AA8VmvXWtr9Y+H2KgkrQp3xbjH1nGYTWBS44z4jV0BtG3rv79Me5e26WoGO
         NE3NzhD/JO/TftFbz7PTNOZm/eGPZN0aGynNLybKbDl0UUFGhEbx12bA+CSi3QpAbA3t
         ioBslgicQOA50hHFVUYwhpOjwk4r4PehcieuSErpW2s6ImVm17rSsByUvn3rkqId1igK
         rlaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=hGL47AsvkQpFBjqI3QRxxpdbSPmI5cqc00bOybuXXDs=;
        b=2QQOq8j6kCganp6qhSWZ0Zh+tSuYgzyP8WU5zNZyti241wwPzb7htQlP3Zad2ePgs5
         UAYriKagA3Li3O5sCVsWIMy5r0ZyvXlqQHtsRbrPuyzfvka4rlB9/le1WBGehSVrrOuk
         9HfdmVwWnPkspbWSoNV4RlTeBYp2kspywGc4HxoCmQw65ggsdF6rQRC3TvFIYLx/V0bi
         ol+bqcDzPD8nE54DnA+IIQvZzkiXjzJXl/NglYkbJM+eTfZL7vE/xZYpX2D9d2sxP0GZ
         IcRQnl+oLhQAo+uKqdDTpSGelfTofmNn3UsjXDmW7iwImIRogvRyosjIG+LDKhc2rKj2
         Xtxg==
X-Gm-Message-State: ACgBeo1Y5Lgd7TKWAWWXE9g3L+AnGg/kjbEumB/mejSYVSuCfviexB3l
        VOhr4eHct7ZEbMrj1NvhBGA=
X-Google-Smtp-Source: AA6agR6DCxHqXrrs2IxLOCxmIcrzJ3hHng+cUNf24dl58oWWx5dfb8RHkwGISW6PekeQvD8ySZNb1g==
X-Received: by 2002:a17:907:2672:b0:734:a952:439a with SMTP id ci18-20020a170907267200b00734a952439amr2141716ejc.539.1662556740352;
        Wed, 07 Sep 2022 06:19:00 -0700 (PDT)
Received: from [192.168.2.202] (pd9ea37fb.dip0.t-ipconnect.de. [217.234.55.251])
        by smtp.gmail.com with ESMTPSA id q13-20020aa7d44d000000b0044eb5b922bdsm4605981edr.24.2022.09.07.06.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 06:18:59 -0700 (PDT)
Message-ID: <041a0915-3c7e-4768-29e1-02a46f347c04@gmail.com>
Date:   Wed, 7 Sep 2022 15:18:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] media: staging/intel-ipu3: Finalize subdev initialization
 to allcoate active state
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220907123359.1275322-1-luzmaximilian@gmail.com>
 <a194a9c5-ac8e-cf86-34cd-4f3a3cb6f6ec@ideasonboard.com>
Content-Language: en-US
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <a194a9c5-ac8e-cf86-34cd-4f3a3cb6f6ec@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/7/22 14:46, Tomi Valkeinen wrote:
> Hi Maximilian,
> 
> On 07/09/2022 15:33, Maximilian Luz wrote:
>> Commit f69952a4dc1e ("media: subdev: add active state to struct
>> v4l2_subdev") introduced the active_state member to struct v4l2_subdev.
>> This state needs to be allocated via v4l2_subdev_init_finalize(). The
>> intel-ipu3 driver unfortunately does not do that, due to which,
> 
> That is fine, a driver only needs to allocate the active state if it uses
> the active state.
> 
>> active_state is NULL and we run into an oops (NULL pointer dereference)
>> when that state is accessed.
>>
>> In particular, this happens subdev in IOCTLs as commit 3cc7a4bbc381
>> ("media: subdev: pass also the active state to subdevs from ioctls")
>> passes that state on to the subdev IOCTLs. An example scenario where
>> this happens is running libcamera's qcam or cam on a device with IPU3,
>> for example the Microsoft Surface Book 2. In this case, the oops is
>> reproducibly in v4l2_subdev_get_try_crop(), called via
>> imgu_subdev_set_selection().
>>
>> To fix this, allocate the active_state member via
>> v4l2_subdev_init_finalize().
> 
> This is not a correct fix. Sakari has sent (and maybe pushed?) this:
> 
> https://lore.kernel.org/all/20220825190351.3241444-1-sakari.ailus@linux.intel.com/

Thanks! Unfortunately that doesn't fix the issue completely: That patch
addresses imgu_subdev_get_selection() but imgu_subdev_set_selection()
still runs into the oops.

I assume a similar fix to the one you linked is needed? I'll give that a
try.

Regards,
Max
