Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480074DBC0D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 02:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355529AbiCQBJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 21:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343725AbiCQBJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 21:09:11 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF70C63E3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 18:07:55 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2d07ae0b1c0so42782817b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 18:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2tFRxT0rhwghQI8gEvi47agtg8vGan10MotjOAuSr6Q=;
        b=UJOX6oklTwkW8w72dCmc8m8zhGfK8OpqY0/JVXhh45Qf9zajdUvJ14OecbKjeXTDIs
         OM3lvFrvqyTnAzZVECEKF6QZ3diKcgggyF082T/v7AtjkiOrjGQhVeFx9jGG4FaZMKo2
         /ym8+gOqDqEiR8ZDRXt8IjN/mjety+rHghP+oqxFfyGl4gpfTgfKTSOUhStMHJ2oTh0O
         ULFgNodNSUChULDs2nHrd6T0fE9xmpCMcP6oQUhbdTx/SBsul0rXyl9MMmaGVMrywVky
         vj+2LH5h7FeYGb38x/w1Qf0qKpcDpoaigVkx0OwS/uBcEaqr+kdfCutCk5cHI4FhCj3v
         unoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2tFRxT0rhwghQI8gEvi47agtg8vGan10MotjOAuSr6Q=;
        b=BlFfiPtNy4PJnzfFez57o09kxlDlCQmgVpgHPQHtEkP0WXpszdmImHOZ2aI27xqovj
         7/Q8hc1l28HBf0juhwkf/u/S7b17IgIU4NPR2S+VnzB7VUTQM/4Ii7nVElUflRjHYn/0
         ZuW3cLO5rgNUruGAeNsAi6QbIxilYc5qCkyGedRJ22RAHOZKlxCJG7ALq4YgPc4+/uHr
         wVRv+ov2wKClubafqF1kSrlQW69Atyjh5Dp70ld0i5GtCgs7/n/tGGxpOV0SNPv7jQIP
         aA1SYqTMnLnzL10CRGeU+2fvqwiF/5XgrC1foKKqSvwYchWh51f4afWIEL+AU/ynYobl
         ALhw==
X-Gm-Message-State: AOAM532/+uV33Djzx/OoXHh19OG2CBCC70H48/PPXuCZdCepaC6VCoNW
        AMb7zvxPk4qkAyLe7nN3IOSMUFvj8XdvHztnYWPS/Q==
X-Google-Smtp-Source: ABdhPJyLzDO8+2Z9/Iy26d888RjB5pB/JHSL2FsWcJtTJ3c4CwGNFG7hfFkA0IlkcXmr/Z6sEsDLQrOFpMY4U3ojLsM=
X-Received: by 2002:a05:690c:9b:b0:2e4:da22:2a71 with SMTP id
 be27-20020a05690c009b00b002e4da222a71mr3697904ywb.126.1647479274986; Wed, 16
 Mar 2022 18:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220222111144.20796-1-angelogioacchino.delregno@collabora.com> <a06003ae-2dcc-f5a4-3b5c-62db99d18950@collabora.com>
In-Reply-To: <a06003ae-2dcc-f5a4-3b5c-62db99d18950@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 17 Mar 2022 02:07:43 +0100
Message-ID: <CACRpkdZnz9ry74mGZ-SvxvVt0NOZMpjGVL3KayK+xRXgRKSQPg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] MediaTek pinctrl drivers cleanups
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     sean.wang@kernel.org, matthias.bgg@gmail.com,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com, wenst@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 11:57 AM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:

> Hello maintainers,
>
> friendly ping for this series that already got a Reviewed-by tag on all patches :)

Patches applied!

Sorry for missing them in yesterdays batch.

Yours,
Linus Walleij
