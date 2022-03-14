Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9794D8F91
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 23:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245627AbiCNW3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 18:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245612AbiCNW3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 18:29:47 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA19D12635
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 15:28:35 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id l2so33713508ybe.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 15:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qWHNUqN4RPuJ+7vYjuCC+61GwajgQBbNJQM7LJ6cllQ=;
        b=mfx54VUND+tksYeR/vbtsuf8Rqw0eLgWGmJdnX62ExXLEOu9eKylDVL20CFBMls5nT
         1N7agP7N/TTm0WB5LYMTdDTccZVlrguzVQT1u5Q5OqAa/nxQfZFT1WPSX6VacnvvYc/B
         NLMnqVmITanUnR3Z2O2fhLb2ZrgeWrXBGE+guyqvKdaqmrQPWMStdEzwXkv5u1Rf5aXJ
         bdbxr7/wnGLNEXaM4llvK5Xzr9nGt4iQqYBEduQytHE3D3nDsgewItxoJvm6mwPOChRX
         BOGysxDi60RjHw5e3Bf5SbifZo0p+iW+AXk2ANZeRo6wr9V8URDVRgEVlBoxoWPSdlVN
         txCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qWHNUqN4RPuJ+7vYjuCC+61GwajgQBbNJQM7LJ6cllQ=;
        b=Og/0JSRJXVTz6kZ57JJ899EJAuXVt+MDH8MSb4jj5WbDkg45Gbd3IL/BZbFe0+cfBJ
         1DhA+YC3U+ssiiNdKgLIamYfKLfnVUMJAQuuxMmM1T4ClzCracHVTyrFpIWk6K2DCX3Q
         eET/3jZnkf+SWtE1U8t1aSNkfmYaL/NP+9CSVcrnP1k2N5nWefnMw1Thlf9GJAc6RpT+
         fRTFJGCjVFzKtR48fcQxcYTzPH7VGzm03WmkiQjyGZJ23SU66OMrqeWynlnoOA8acRmh
         NCOKuKBs8swY0ZEOu02faVKMx7P9EdldEkZJnuHZnE7phUYLUAzd4O/aYQ0EHz5D4aDK
         fy4w==
X-Gm-Message-State: AOAM532c6CWH8FVimKgldwumsjUEix7VISV3yaPyyxW/VeEBj0mmiUGf
        Ju/5LfgtYTYvZAP0H+fBvgbRybuO7xdXd4DE03qn5g==
X-Google-Smtp-Source: ABdhPJxY3aPz3pg9iWcQ54O5HlHHzIhd94s/LV7H9QfgeLcD4LnfyG8oIiLntLd4kof5PBDBI0d0DPOnHZ+ud4Eb2No=
X-Received: by 2002:a25:f406:0:b0:628:c29b:5c39 with SMTP id
 q6-20020a25f406000000b00628c29b5c39mr20736120ybd.369.1647296914823; Mon, 14
 Mar 2022 15:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220312113853.63446-1-singh.kuldeep87k@gmail.com> <20220312113853.63446-5-singh.kuldeep87k@gmail.com>
In-Reply-To: <20220312113853.63446-5-singh.kuldeep87k@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 14 Mar 2022 23:28:23 +0100
Message-ID: <CACRpkdaVXMBu9DYca3NF_injHUZ3YWpdqVMNd_6toG-=ZkCkOw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] ARM: dts: ste-dbx: Update spi clock-names property
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Sat, Mar 12, 2022 at 12:39 PM Kuldeep Singh
<singh.kuldeep87k@gmail.com> wrote:

> Now that spi pl022 binding only accept "sspclk" as clock name, ST
> ericsson platform with "SSPCLK" clock name start raising dtbs_check
> warnings. Make necessary changes to update this property in order to
> make it compliant with binding.
>
> clock-names:0: 'sspclk' was expected
>
> Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> ---
> v3:
> - Reword commit message

Patch applied to the ux500 tree!

Yours,
Linus Walleij
