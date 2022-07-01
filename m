Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C45C563193
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbiGAKjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236564AbiGAKjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:39:07 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20E47B36E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 03:39:05 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id v185so3294358ybe.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 03:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FvJVjczKtDiPL6abszYdMKTMozraAWQUFyZEkrc/JT8=;
        b=dh+SVF87cEY5zYSqbnal08C6dKRjPJnNOKlb1mMKAZP8LVYhRu+8Q0N2o1moi8IzN5
         NEw2E9+JqjSGn5PanmLxNkgDwgOmzxpgSWUzwrVIMggQ0IQnv43D0jH4lpSHkVw4xmin
         z1CL49mZMPMA/BEGxuLz/WvbHIAwgpBBXJYDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FvJVjczKtDiPL6abszYdMKTMozraAWQUFyZEkrc/JT8=;
        b=vDpq7NP1Cm7RDrhJNdokJAJF3psvayREECEyX/ilMX5IglHGJ4kyUIvsUekVFh1nV+
         yD4cgHPFwheYTLbV0lFSdqreBQret8tFsJ+x5+aFLHhHfsHyLIFskzUbLouQuvBmYE6A
         BLr20gioAamk7zR2vidnAq8/tT3kYgxmSMuUqvHAhJNv+3zWyWGceyTbH58zPgiFeEw1
         qRmhGlv3Yk0H+R5PVwl37zPlX2yi43WZhHYlkevOEGTAU94UDilHS6tmmqG4dtxBPEhs
         DX/M1dZmQa5K9DxUHy+VnHbAjmUFJXjh7Yie6M0NB2CviJ7q/Rug41QUq3N1XYaqz84s
         trdQ==
X-Gm-Message-State: AJIora+Sjwn8tYKY/86E3FxBCkREZcpfXHuJWP1SlP018kHcieTJ1sv0
        B52C4PDd1hzAUOyBW4SOVh8hvvd2EOTBrXOrDKYTyQ==
X-Google-Smtp-Source: AGRyM1srrLz3JQ87+W13agmcb1kXXtofB5K+QT9XZkN6dy2Rpvl7sdgAuv0zOBNAjH/1QNRT/nW2/BLw5XDm0zzHvs0=
X-Received: by 2002:a25:6644:0:b0:66d:c0b8:81ab with SMTP id
 z4-20020a256644000000b0066dc0b881abmr6710851ybm.85.1656671944937; Fri, 01 Jul
 2022 03:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220629155956.1138955-1-nfraprado@collabora.com> <20220629155956.1138955-18-nfraprado@collabora.com>
In-Reply-To: <20220629155956.1138955-18-nfraprado@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 1 Jul 2022 18:38:53 +0800
Message-ID: <CAGXv+5FdiJQV68JaBPYnV9Gd1GhUF=6gvZ7ZfkK6ZuyRzVsGkQ@mail.gmail.com>
Subject: Re: [PATCH v4 17/19] arm64: dts: mediatek: asurada: Enable MMC
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 12:00 AM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> Enable both MMC controllers present on Asurada. MMC0 is for
> non-removable internal memory, while MMC1 is an SD card slot. MMC1 isn't
> used on all machines, but in those cases the CD interrupt is never
> triggered and thus it is basically as if it was disabled.
>
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>

Tested-by: Chen-Yu Tsai <wenst@chromium.org>
