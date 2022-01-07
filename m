Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F860487EA7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 22:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiAGV5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 16:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiAGV5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 16:57:05 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F98C061574;
        Fri,  7 Jan 2022 13:57:05 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id b13so27080894edd.8;
        Fri, 07 Jan 2022 13:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jJxRNYRzNNkqjFe/hktJforwUgorgEb4Zywafu/Jhjk=;
        b=itnTJTnM2Up3kdjCIHNH5zJPK9Q/5I9s3ZAFX0P9KOdeUMqTw5V2ro5qKubiTUydQE
         3Zq5xiB5pnnmr37xJ1NO8xi98v1mwZ74QJh8agjY+zfCzCYoc6Iabqb3p0PH243aIiiz
         PQVeHxefike90JsZez4SDZveskBbTcarAgP04i7ZNg0SEzVPjZpi2HfrnwPBpguX8TxF
         sFdqU4CGXFHq+Q2HH8LHdQtzARZxd2ib36F98gJ4Fvjz6De15r47L4VxxWp9qgrADKQE
         htpvDMrlVQcztDvmxsY+x66U+da3vt/20xFHNemDpnpEYHIePG/AMDv0hET0/z1lhXj/
         Vc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jJxRNYRzNNkqjFe/hktJforwUgorgEb4Zywafu/Jhjk=;
        b=Q4UXah4vQi/gWKR2ZJZMhoxnTK/b3bcWGLDjOdaGd4EHReyIV2gw0/KYQzEdHvHqAq
         MGBDBckutTFtSOj5ImgLL8g+HQNlwkf7+Zgdz5StGoRdzFecomxT9+mg/PLvNiThGzqY
         /tEWE9tTPBvKVyO0WU0lGu26CVH31OpF4ERiVsEW1yNAGxCvWOxbNlMgWBhdceJ7F/z8
         jWVETa4O331kwZO/PoowL3IDBV2Lz/Fm9cWVb6RDXw0oUouVQWpfAL4g1iWwGjMGF30z
         YhSZE7W01QY2DxwBS84l8hdoDaib2lIXNa3e79qt3GjLCQd3hV6VnsKDxEICO2RAaWOm
         wuPA==
X-Gm-Message-State: AOAM5319JgUuotMbckLWLOBXggkKbm66QPoOg5eRty9tuafUD4ZIV6vy
        Tl0a+7LqDKZNA6wvY0V/Jb0Acndnvv2pF2uPXx4=
X-Google-Smtp-Source: ABdhPJw9LQk5Y9g+qc0okCpO8oOdvPbFrEB4gik9GEK71+mw969kHOZrkB52XksF13OPKMDsQx3WwgydLAgkPLcWjwQ=
X-Received: by 2002:a17:906:b00c:: with SMTP id v12mr17527543ejy.543.1641592623608;
 Fri, 07 Jan 2022 13:57:03 -0800 (PST)
MIME-Version: 1.0
References: <20220107023931.13251-1-zelong.dong@amlogic.com> <20220107023931.13251-2-zelong.dong@amlogic.com>
In-Reply-To: <20220107023931.13251-2-zelong.dong@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 7 Jan 2022 22:56:52 +0100
Message-ID: <CAFBinCDrfpjCDu4Atwx9n0KAafDyCQnBSd5fNFV5NgM1xgU-NA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: reset: Add compatible for Meson-S4 Reset Controller
To:     Zelong Dong <zelong.dong@amlogic.com>
Cc:     p.zabel@pengutronix.de, robh+dt@kernel.org, khilman@baylibre.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jbrunet@baylibre.com,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 7, 2022 at 3:40 AM Zelong Dong <zelong.dong@amlogic.com> wrote:
>
> Add new compatible for Amlogic's Meson-S4 Reset Controller
>
> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
