Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBD0563196
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbiGAKjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbiGAKju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:39:50 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C061E7B377
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 03:39:49 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id d145so108469ybh.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 03:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QhSJpdElfxLJFyuRKCFkIgo8J87kpfyiNf5gNwRrRdk=;
        b=ocasRLLt7ZDwKINnqCUl5FR0RNg3PQjS5gXEQjvHSeo7W055JZlxinK2HUcaK9w5bh
         eSN5A/+QtNlO1aX10mlD2JbNYLvX64ZhASo914nhKidpwAtpvu4Sta1SN077iSfCpy2t
         CkzOa6S94V0kN8rvcfmrtw6/E3rj5yp0k5AJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QhSJpdElfxLJFyuRKCFkIgo8J87kpfyiNf5gNwRrRdk=;
        b=tmL7M0uG6IBVm07xLpdmMAMtbp6YuRzpiEnBh70dblJO0ITXRLDj0qbyR09M+eb/k7
         V0mvguC1Gz2Aii3iI99NnTnX/YPg7d5e/jKj2PajHLoSPeLIqjm5a2tU1aYvzpJsYpwo
         ZDnNNc4PMap2Akp+jQzcpJCYnjjmFJEU6hCF6LoEx5FhtXYwKK2pm5JKcTqXzW0KW3zH
         sFdFJflsOclbN+TNOzpp4hyAA9NIDcDh4/uzmq1TdHD6kjkMi8+n2RrQTFqEw/g73BBN
         JHfAhRt9jpwWC/zA2FP6cKzKOzsQbS94eawWrsIXfCcuRnVBKe6oU+SWtYXIEV4M3dyd
         yUzw==
X-Gm-Message-State: AJIora8lmvCcx4YwyiDmwTXf6RXFn062F2JkwPmN14ioxlkExUTT6wsp
        USzUocn9bpCeIXrdWYkHM9sUCNTA0l2Ju5hIynF9fQ==
X-Google-Smtp-Source: AGRyM1vft/EQMm1oncXjofFh3jIP3Ex+EX4u97g9AM0PzBmMCHK71dtxNdvf6XCacmM+Xex1pm9BVN9k7B5IjJg8Hv8=
X-Received: by 2002:a25:7801:0:b0:669:b51b:10d0 with SMTP id
 t1-20020a257801000000b00669b51b10d0mr15080419ybc.204.1656671988852; Fri, 01
 Jul 2022 03:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220629155956.1138955-1-nfraprado@collabora.com> <20220629155956.1138955-20-nfraprado@collabora.com>
In-Reply-To: <20220629155956.1138955-20-nfraprado@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 1 Jul 2022 18:39:37 +0800
Message-ID: <CAGXv+5FEM0UNg5vCK3qF6yzhCPWDryQx0iEzhFJJEQQhpx1M-w@mail.gmail.com>
Subject: Re: [PATCH v4 19/19] arm64: dts: mediatek: asurada: Add SPI NOR flash memory
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
> Add support for the SPI NOR flash memory present on the Asurada
> platform.
>
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>

Tested-by: Chen-Yu Tsai <wenst@chromium.org>
