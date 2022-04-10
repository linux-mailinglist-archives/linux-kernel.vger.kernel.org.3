Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5644FAD9B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 13:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbiDJLGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 07:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238178AbiDJLGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 07:06:41 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3ECC443FF;
        Sun, 10 Apr 2022 04:04:28 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n9so11598086plc.4;
        Sun, 10 Apr 2022 04:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pj4wq9+LbeDRlRaJUHKgoygCg5/94JkoueAy/3cHRMU=;
        b=qIO5/T0fVdupMRtS8+fLGpOvOKPDM4KAhTkm38bTErUgOQNCC5Mwlhxx3fytnZtrz2
         I2uwyaRnweWl26gTX3UV0uE+gcJsrLsfn2F5VtLdo/YxCtRTZp0z8bWjR+pYeMxHgZHv
         fkPODSnTKvqVBkYoQy/59iY/pyo3U3ip6un0/U/wOyF4PwvJ+6/UBIqjcDnIcx2aWAXS
         MifOgafzXfijTC6BQ2GLWblXvbOIIGD/7YfV3aCx0UpAcLaecebWGlow/ijYEx5yStnC
         ie7tco4Ww2PFb/OqjLYiy9woZfia8mft2yZZdiFP8/dBgcTowB5eTGn3Eo+oiP0xhBNN
         9lcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pj4wq9+LbeDRlRaJUHKgoygCg5/94JkoueAy/3cHRMU=;
        b=6WljTXxLNkOP6+exs23XuX6UkMXPMTpNCezO+HBzPI88IrO2Oo+7ziqp4VbJ/xHzNf
         zNVsW+Y5QbBm/LO6WRgDjfVoMlF6mJ8SqUo/MeK9v9VXdOlHiRX9dUYhst8R26xJ1AoO
         gMg2M/BnqLUkkpCBUXKOSorOw0x/8DvN3loOdD0NwVTuJAf9bVq+v7tEwc7CYMD46RM/
         C+FrS5gB1E1dcNLw/eeX6S9PSBfz13nFI5EjWBrlOP9Ts+YcnC/+Z9uqu99e4dVjJNm2
         PbV8Zx9yOxTNPV5vSV1cl3V1WUbXRCGQVsHSUrhSqDKDg6XUMX1FPBaa9CG0npPemgrP
         /lEw==
X-Gm-Message-State: AOAM531WlAXNbGzrmwvZmG3JVOnEQ9U9XoYHQ93RAI2Y7gX1jNRT0sCq
        oiBDUscIVmod7jKOR6dh5JA=
X-Google-Smtp-Source: ABdhPJzujYvV7CWWoXSyGZ69+3TPkzbbvHelnSV378sOBT2+lmQjwvofcVYT2LoBFyWuE2vupzbLiw==
X-Received: by 2002:a17:903:22c6:b0:154:4156:f397 with SMTP id y6-20020a17090322c600b001544156f397mr27570170plg.29.1649588668101;
        Sun, 10 Apr 2022 04:04:28 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id m8-20020a056a00080800b004faa4e113bfsm33069670pfk.154.2022.04.10.04.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 04:04:27 -0700 (PDT)
Date:   Sun, 10 Apr 2022 16:34:23 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/6] Covert Qcom BAM dma binding to json format
Message-ID: <20220410110423.GA6249@9a2d8922b8f1>
References: <20220409184115.15612-1-singh.kuldeep87k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409184115.15612-1-singh.kuldeep87k@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2022 at 12:11:09AM +0530, Kuldeep Singh wrote:
> Patch 1,2,3,4,5 require generic node name for dma and 6/6 is actual
> conversion change.

Need to add more dma-controller name for ip4019 and update in binding.
I will send v2 with updates.
