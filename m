Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD5850E8BE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244636AbiDYSxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243538AbiDYSxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:53:37 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C1890CD1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:50:33 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id kq17so8268013ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=I8OGAy692x2HlX0zDRT2WU4OQLJqBZjTeofFJMqhneQ=;
        b=yJtZUQbKaP4+1vaymO4wTdai+PwZjfZGL0Qv/GR27elZWHbpeL6kCjftSG2f0FChs/
         PL5SN243GPEnWSJ3LQTJXQZ146BTqccn2NGQL2nVfINMe4oWwerIYVRjDL6Qg1bnsdFs
         V15im6vwngYNzIohkZBUJ7Cd1jhBPdxlX4MGD+5qqiDnAutR2PAfLdSFIIFBzzT+PE3D
         Nip0LKHDnt2jITH47p6IeSNy7hXKUSimfnbs/tOfVlSqHn6ehA1AOaDUvcVX3eXNOxlj
         w/sYwfMmoWjBqtijJlFIEx2Fa0CnQOMzea986Z/A0BczlPCVCzTWkaO7nTUFLKJIP6NG
         Oijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=I8OGAy692x2HlX0zDRT2WU4OQLJqBZjTeofFJMqhneQ=;
        b=M84GDsjw0MyFgVaEtHwny0dcr5SRpZR/8Jm7hsJMxKZjoWbwqtgwpHkG0e61+Ox0xK
         UbyUTXFa1JJ77QdQMGMFBfpkysBW26ILV6wYEpDC/kTBqcN3tyLHuR9GwTyDIT7/APQf
         qmGrH8RvycwDx9W5/HbQGi9zIHOkXClhMZJulKyKsb22GaQBhWlrSpW2yfpD3aXVylfM
         mf1dyhWal2j0HOgPEP+TcN/NXAKg65ocsLFjoBYUFoCiGYZScP4a+NBucDgRvm/TN/29
         cgH7RSxwc+JgAEMGcugEkQIaCndMVWQlZkba/rKhxLjVdK1g0tBdQQMbsCraKNmt5Fdk
         lZPw==
X-Gm-Message-State: AOAM530YyFX43LO2hN1NJ8SP5v9RKHOXLWWDyeK4/meYabjYOlGsQC0W
        XP+46+AEgm1YEauYnPh6v+6B6w==
X-Google-Smtp-Source: ABdhPJwRiWolCCzfTOXvZ/aMVmJ7USEy6FBXDNaZxg/9Y1L8Bsf/Q7l9Ym1+l8z14ohrkIth/+dThQ==
X-Received: by 2002:a17:907:72d5:b0:6ef:a49f:133a with SMTP id du21-20020a17090772d500b006efa49f133amr17969076ejc.420.1650912631700;
        Mon, 25 Apr 2022 11:50:31 -0700 (PDT)
Received: from [192.168.0.244] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id p24-20020a056402045800b0041614c8f79asm4937824edw.88.2022.04.25.11.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 11:50:31 -0700 (PDT)
Message-ID: <4ab44d3b-8a10-e24d-7c60-f0073e6e89f5@linaro.org>
Date:   Mon, 25 Apr 2022 20:50:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/3] media: dt-bindings: media: rockchip-vdec: Add
 RK3328 compatible
Content-Language: en-US
To:     Christopher Obbard <chris.obbard@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Elaine Zhang <zhangqing@rock-chips.com>
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20220425184510.1138446-1-chris.obbard@collabora.com>
 <20220425184510.1138446-2-chris.obbard@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220425184510.1138446-2-chris.obbard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2022 20:45, Christopher Obbard wrote:
> Document the RK3328 compatible for rockchip-vdec. The driver shares
> the same base functionality as the RK3399 hardware so make sure that
> the RK3399 compatible is also included in the device tree.
> 
> Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
