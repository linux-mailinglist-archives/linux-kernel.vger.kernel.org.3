Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33820563197
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbiGAKjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236585AbiGAKjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:39:22 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5307B361
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 03:39:21 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-3137316bb69so19128097b3.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 03:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Qdoe7uBh5YdgvwDoXEs4z1E7HWiqcjddIo/k1Wuymko=;
        b=Xb91NjUW1NKOPKi4zPVohamVP+8ax7DOIzihV1AuAcHJuFg/wSUZ4VQSqo9g4umKKB
         PP3nvsfaz/wdbShIqCD2QerXBI4Oa/GDcwV/Gxr4OsISgq6SVElNyQK29wHQhiBHjTZ7
         3cT/zWNf4ePJBtSiNx5pKWo1zZx+eagvmQpws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Qdoe7uBh5YdgvwDoXEs4z1E7HWiqcjddIo/k1Wuymko=;
        b=qFcPdt8kIQXjuN1eEk87nJlpenHS8sReyJoNl9pBf9PXV04G6som0/JS27YYVnYch/
         17gc2X8kgraxFLyIXGW/9boPyP3jBtAVXCCGBVxb2aNs2hRQ8hcOcNZ0Sml3tyUUbe1n
         vZ5eiMHlv6X79ZfGh3UhJKPjdvFbNSWm6UBDnAlnUjTgarpx8rjq3y+W8rAKOve79uNF
         rGvrCr4RUxdGxaUDHrvej0I0A1XOhMhaWLmCPwkA3Zw0T6prbHsGKy/UdRdK8cD2fTB1
         KuurRHMmleDGKaxJVKiXiBgdi4wocaXIJgrYwAt3eCHGo6LXkNIS9XMg/E3n7RCHatK6
         k3WA==
X-Gm-Message-State: AJIora953ZR4mifp6+jrn4lsvBo3Wh9RVhq1K1wwpSDug7ZPNd3q8lSY
        uQwneYUrWkz1YtZn6MXTpZKmRfbm84vw5fLAjkqVjA==
X-Google-Smtp-Source: AGRyM1tbkJBX9Hzk5eZ2TzQQEIas6RfLq5EG7NxvFxwC+16yjoYuQTo0iO6rbWqDLmQcGCC2g9iUmZB7QTkK9dbk+4Y=
X-Received: by 2002:a81:2386:0:b0:317:6586:8901 with SMTP id
 j128-20020a812386000000b0031765868901mr15850223ywj.195.1656671960400; Fri, 01
 Jul 2022 03:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220629155956.1138955-1-nfraprado@collabora.com> <20220629155956.1138955-19-nfraprado@collabora.com>
In-Reply-To: <20220629155956.1138955-19-nfraprado@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 1 Jul 2022 18:39:09 +0800
Message-ID: <CAGXv+5EmQRup7x=qsTLMj-90Y0TB7mAcisOVmwm4kFiD8Lhwrg@mail.gmail.com>
Subject: Re: [PATCH v4 18/19] arm64: dts: mediatek: asurada: Enable SCP
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 12:00 AM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> Enable support for the SCP co-processor present on MT8192. It is used
> as part of the video encoding and decoding processes.
>
> A region of memory is carved out for its use, and remoteproc setup for
> communication with the ChromeOS EC.
>
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>

Tested-by: Chen-Yu Tsai <wenst@chromium.org>
