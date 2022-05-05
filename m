Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F9851B625
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 04:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240094AbiEECyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 22:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237139AbiEECyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 22:54:45 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0EE4D61E
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 19:51:07 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2f863469afbso35498767b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 19:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hQ87eN9SQZi8NIJ0dQLJS+dLce/vvTzOM8adEXAvNpY=;
        b=Le7GeHdTtmB5SEv2vlD7zJRJo2n5QshLycQemr00mvMeqoY81qcNLBHXHiJhUZzKbi
         G42atpj+pi97+SAOT5ltJpCB55xi3goWnfEZsyMZeKKjGx72SadV4XMeYTOOB/j/Ch5I
         cKg/UJvPDk/A5xrlnxZSMCG5I1DtTp79k9R18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hQ87eN9SQZi8NIJ0dQLJS+dLce/vvTzOM8adEXAvNpY=;
        b=zgaJP9t3xWGgIVbeYx8gQr3xTglEwM/gGQQXHf2PqpyBKWVhWlMkiCGyRi/UPabINF
         fR6zUXuFL3xCHbny3v5mimQYKFyRLGE/D6YVnyl2bUmoja8ypP2zDRqBM0998+51ojf8
         r8o9uh3R5SHB565Rfbj6jMugoy4wNOD13bRX1i1F89NGX4O8zJ8Bpb5Xwb2ZYUd8Qq3+
         6M8ijdfMWOS0Phap8qnkeJZ3FE70x67vxrN2liOgFb27XmkaEyKmiapVXphzev+Qeatg
         KWf1p2HY6v0Rj5JX+GTQbIJlZnsliUCueL5eLdwQa+9WL6ZzN7mOt5U7D/+pvxZZdDzr
         8E3A==
X-Gm-Message-State: AOAM531iWdILl1iinWiv0+DAZi5rPK4pBMRWrmXQ6d4FV6gtLfbDujyh
        Vdh+35XRKqaYJN4fMn1u95r8Q+hupHlfxAQoM/xEWyalnCQ=
X-Google-Smtp-Source: ABdhPJyAKMpcVpgskbnOy66gjUlw5KH/+b9uJG5rcYjxVXxuwcOYSmCeTcLTWA1Tu+QO4F7WHXLWo3pCF2QtRAd5yPc=
X-Received: by 2002:a81:be05:0:b0:2e5:6c26:59fb with SMTP id
 i5-20020a81be05000000b002e56c2659fbmr22963642ywn.94.1651719067116; Wed, 04
 May 2022 19:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220504214516.2957504-1-nfraprado@collabora.com>
In-Reply-To: <20220504214516.2957504-1-nfraprado@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 5 May 2022 10:50:55 +0800
Message-ID: <CAGXv+5EOactKnHkqq4E8Azkn4MGG8VHju4F8ZWWcaYeyy2wUww@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: mt8192: Follow binding order for SCP registers
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 5, 2022 at 5:50 AM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> The dt-binding for SCP documents the reg-names order as sram, cfg,
> l1tcm. Update the SCP node on the mt8192 devicetree to follow that
> order, which gets rid of a dtbs_check warning. This doesn't change any
> behavior since the SCP driver accesses the memory regions through the
> names anyway.
>
> Fixes: c63556ec6bfe ("arm64: dts: mt8192: Add SCP node")
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
