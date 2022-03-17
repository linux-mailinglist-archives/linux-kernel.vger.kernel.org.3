Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14EBE4DC445
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 11:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbiCQKwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 06:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbiCQKwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 06:52:11 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C5518A3D1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 03:50:55 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ja24so4420179ejc.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 03:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KZmBzh0g7fh31Uux2XaPjJ672KEz3K8+xbFDHdajcWo=;
        b=dVE5pNc2uLKjdR6Hn4y4VHcCXBIgSt7AwoR19xYnhW+IX051fUoTEK/2DhvTC7mm7H
         91NGgNDnqvBXVnQA9eVQjCUqecf8qGXZkdntTB/JrKBQZMPO+UIZ0tS5pHGGueb3ItEM
         nGBhhrgATc1/h/pgpMgzNiifnJdVHF1Gadc87Boa6BE8ayhd/iiuxXZi4Tz/kznk+X2I
         fnagAYdL1HNAU+AHRjwWZ2Ow1vy7cCtAB99MqQrJi3+/yF4TSXreHyP3IGyPJTJLz93r
         0S8FWY1gHwd7yD2g9MwE6F6vVOCWeMYUfngcA/oKTSX3XBvuAbqz86zuT6BYWda6erWL
         aSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KZmBzh0g7fh31Uux2XaPjJ672KEz3K8+xbFDHdajcWo=;
        b=JWa6hkNzeUq2rH/ANVV+k4iYdQatqBk/zhBkQ6mQpPO50bGEip0XRmOclsG3zucxq1
         5YJu7Ic4DZo+Iz50XwjxnrV1dSGqBwapXzwyjUIR/H6EpeKalLlF3b7X1XNlvCBh+XxB
         1U1Z8KspfKeXtBHhUB2ullyqPqtsZYk8pa3f1Ys3T4c3+Ppea7v8cfM8X6m0GR097xHx
         KAVUm/HkZMx0XTPnz3N7iSgXTdhRioZSODlRsS3yO7duY032WwtyD2Myh1kwcFgxfVtT
         6tzZVmJuIu2EEKv7PSkqah6EeRw9Va7X7rDiB3Mf5Q2Vtb2YQAo48jZoRAjL10zbjqxo
         avzw==
X-Gm-Message-State: AOAM530yDWxR6rXXGyanNeZ1PB58r/XA9QbcQrHrNFMFVRZTVnQlfns3
        2gGyp3V1VARWetiACJfuGTUNruf/cGhM6vRSfeM=
X-Google-Smtp-Source: ABdhPJz1dLjFVr15ZSB8rE/IA7xtmuIxUdcKJlREUgs294eudErB0vgAC4mFOs9FDwPmeTg8gweiWh1Df8EZLXt9WZE=
X-Received: by 2002:a17:906:d554:b0:6df:a6f8:799a with SMTP id
 cr20-20020a170906d55400b006dfa6f8799amr437899ejc.492.1647514254256; Thu, 17
 Mar 2022 03:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220317041806.28230-1-nicoleotsuka@gmail.com>
In-Reply-To: <20220317041806.28230-1-nicoleotsuka@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 17 Mar 2022 07:50:42 -0300
Message-ID: <CAOMZO5AzRY_tk_9NbMCCuO8vYOJnVwWfQWwURsWyU9u0L__Z2w@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Shengjiu to maintainer list of sound/soc/fsl
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolin,

On Thu, Mar 17, 2022 at 1:18 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> Shengjiu has been actively working on latest FSL platforms and
> keeping upstream effort as well, while I have been working on
> other subsystem lately and cannot guarantee audio patch review
> in the near term. So replacing with him in the maintainer list.
>
> Cc: Shengjiu Wang <shengjiu.wang@gmail.com>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks for all your great work:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
