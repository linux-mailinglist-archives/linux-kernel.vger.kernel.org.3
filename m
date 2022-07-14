Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A1D575156
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 17:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239854AbiGNPBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 11:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239849AbiGNPBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 11:01:37 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A0C6068A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 08:01:34 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id y11so3259876lfs.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 08:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=MIvJ+dTvC2QCMrwX9S6dc6CiUQzlyJP9LJtRNfIgjKM=;
        b=rCN5/JSlxwK3J4+DDpco0pWRJRIt0odUB/5Yp/Qahsjwi0O6HfyyaVCZaa3WLkj/+k
         r97rotwWMIKWo22DGvWqQmlfCdZZppvzaodyD/zTkiHv016EomPgp+IRX0KIedZselw4
         cy2ClqGNDaI+jZwC/0IaVjtEaBqKKmtlXn7FN0Rqo/tBszN4yTxqDltpYgKh+pmWYsEG
         4I+t6q370K1wcg3hxFI1QG1RFdPJa5JkzimCprcGIzhRCdWAU2uvD5QU+E+kZ2xDMASD
         h52l741rzmXFMTDkcEEB/Vzh920ybH50dSWXzY+qWyISo8bYptYTmnPnIFl2FP6E0gbd
         WMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=MIvJ+dTvC2QCMrwX9S6dc6CiUQzlyJP9LJtRNfIgjKM=;
        b=T6AvTuc4Rn1N/MrjXwProLTsp9qbrCNc3ITGyfsBUUY0KRtrZUCBCrFIc1Et2vp8jl
         XNUFoJeuqu8CPgePJ/iZFUzsKP9sOrk4w8BFI48AjA3u7vV7JETnT3esh6DFLd669ZxB
         sngm+3L1VGg1iPx7MkUbmpzp+xj7R7r2BcidwdXdUJ/IEp5Uo87o55nOB/agFNTrng1E
         hEM5L+xNH0wTbGtjTqCHx1fJC6Pm9q26PU+MuYmdJ/nOb8Gje0aZRgg+O1BjEV0Nf4DQ
         R+ngFRa2jzRlsr2oQJOnKQu4OJLLVjE9qdpD3pEUnR2Rt4eEqAF2Jo8xxkK7ek9u/+sd
         J/2g==
X-Gm-Message-State: AJIora9jhnftlt4V2kmSFwsqb5y7VQtjXuVxx0YidH2RXiBJb+1CH2wH
        BYmuCe66K1cQjqsrGiAGQFwo8/FO4Bu1VA==
X-Google-Smtp-Source: AGRyM1tXfnUyMCAtrzJ677sUr0DbtxIm368B1UCe2FmPYt3SweTXtKsvKLUf5tKTzmeLxKxkyU7LEw==
X-Received: by 2002:ac2:4e12:0:b0:489:ddbe:83c5 with SMTP id e18-20020ac24e12000000b00489ddbe83c5mr5754993lfr.371.1657810892811;
        Thu, 14 Jul 2022 08:01:32 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id u15-20020a05651220cf00b0047920d89606sm396700lfr.187.2022.07.14.08.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 08:01:31 -0700 (PDT)
Message-ID: <e759045a-bc01-c194-35ad-42b534ccaa01@linaro.org>
Date:   Thu, 14 Jul 2022 17:01:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Question: regmap_field_write() - why using update?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I am converting my driver using MMIO to regmap from readl/writel and to
my surprise I found that regmap_field_write() does not behave the same
as regmap_write(). I would expect that they are the same, except one
operates on fields.

However regmap_field_write() uses an update method [1] which means it
reads and performs update. regmap_write() simply writes without a read.

I find it inconsistent and a bit confusing. Any reasons for such
behavior so I won't send a patch which breaks 100 of devices?

[1]
https://elixir.bootlin.com/linux/latest/source/include/linux/regmap.h#L1307

Best regards,
Krzysztof
