Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BB150E285
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242254AbiDYOCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242296AbiDYOCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:02:53 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C92E888E6;
        Mon, 25 Apr 2022 06:59:48 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id p8so14850721pfh.8;
        Mon, 25 Apr 2022 06:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=U9Wjvt/VVtyGnx2gynxkIq7TC4qs0Sv68BPfUKYpPQ0=;
        b=ZcsfDlOIFwZM39m/IxN0g/tlNL+hrCsPSv6JzypZl9gYTalOG5a4hh1l2fCoY4m29S
         zYpvFWUBCTg8AlJUhsrEllvaUpJ4j0uZaiQeI2NfwUohL2xSPWJCTZ24qtUAkKtRlRzz
         djcsf7npJjJOR/sdRybdIdDxyY1oOqtA0kW+Ped/uyxOgCQ+35BgNbJUjUIVKctxDqpH
         O+U2QPaw+g14OMsYAE8KjpIeA+zy21+Tfev4wy/AnSRWoaiplJged/Bdsxpd2Ma4mzCY
         /DFyS6UKnGRGjVegt83lJBvCFiCmKi/RlRnWXcipwajZN9ZYqSGzh8EeKl7knqauHhg0
         28Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=U9Wjvt/VVtyGnx2gynxkIq7TC4qs0Sv68BPfUKYpPQ0=;
        b=AwNQP0N43txPzVYhpakAbzmFb4hWxM107yjeybqa+gfyf/gJS2P90nn2f1kn1MA5vp
         7Ospv5qCEW1IPIDvkj63SYo4VK/xhpcdw0+8zpteGK3k/wcwrRjf5LyLz8fNXdlIY8Z+
         sUbcEvtI/yD2O994HwmPoOaaFcGB9J/Vo1F/md/WIsuNCUnE+coJnPeUwz+0C8Xksf/U
         NEwaJPcnyxOkeDS05JKe5e7kk8HMh6gyjVi7ONwTOLBBGa6iQdE1N7meFmWFxoGO4+Ja
         OEmN0da+N4XuvJnhlMhpAtflhxVbt/zq6YlSZDRPCsZ8k2KvVLbLTCKsjAFPyhzlvdHC
         p6AQ==
X-Gm-Message-State: AOAM532yMjb1CzxDYpJwACe+Hz0+wWD+UqWEGAiTuk9/a+/v+wxr2A5R
        1lnPCqHutwGRK/VpiXr8+OE=
X-Google-Smtp-Source: ABdhPJww4LZvZ49fuCfm49ls7d2wLu5v7RbMyxRVzxzAienUjJ1CFcm+Rwrx4uobvPMe3ckLtdwnfA==
X-Received: by 2002:a05:6a00:8c9:b0:4fe:ecc:9bcd with SMTP id s9-20020a056a0008c900b004fe0ecc9bcdmr18936853pfu.34.1650895187844;
        Mon, 25 Apr 2022 06:59:47 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id b13-20020a056a00114d00b004c122b90703sm11999538pfm.27.2022.04.25.06.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 06:59:47 -0700 (PDT)
Message-ID: <0056f4fc-e5ec-35ba-4c6f-0fb09bd504b0@gmail.com>
Date:   Mon, 25 Apr 2022 22:59:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] docs/ja_JP/index: update section title in Japanese
Content-Language: en-US
To:     Kosuke Fujimoto <fujimotokosuke0@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Tsugikazu Shibata <shibata@linuxfoundation.org>,
        linux-doc@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <20220425124853.8347-1-fujimotokosuke0@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20220425124853.8347-1-fujimotokosuke0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022 21:48:53 +0900,
Kosuke Fujimoto wrote:
> Update section title "Japanese Translation" in Japanese.
> This change is to keep consistency with other translations.
>=20
> Signed-off-by: Kosuke Fujimoto <fujimotokosuke0@gmail.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Tsugikazu Shibata <shibata@linuxfoundation.org>
> Cc: Akira Yokosawa <akiyks@gmail.com>
Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

        Thanks, Akira

> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/translations/ja_JP/index.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/translations/ja_JP/index.rst b/Documentation=
/translations/ja_JP/index.rst
> index 20738c931d02..43b9fb7246d3 100644
> --- a/Documentation/translations/ja_JP/index.rst
> +++ b/Documentation/translations/ja_JP/index.rst
> @@ -5,7 +5,7 @@
>  	\kerneldocCJKon
>  	\kerneldocBeginJP{
> =20
> -Japanese translations
> +=E6=97=A5=E6=9C=AC=E8=AA=9E=E8=A8=B3
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
>  .. toctree::
