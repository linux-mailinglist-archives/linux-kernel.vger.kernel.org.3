Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4813E57A7C8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 21:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239038AbiGST6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 15:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239876AbiGST5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:57:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199EF5F989;
        Tue, 19 Jul 2022 12:57:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F24AB81D14;
        Tue, 19 Jul 2022 19:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79776C341CE;
        Tue, 19 Jul 2022 19:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658260631;
        bh=ttr13LeCzuWb0mQqZMCxUwMmOqVOMkpEHDBdwO513xY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tIIL85hj56Is7sR+SPakwhka9ukvoxiTzAWPskjP2Qa8yF8YZN+0zCaHUuNu9uehN
         mwylr9+YuUhvL412WqlCUMP6DgdbxFALCLh++U1sU2BmW5VA2sYC5x7JtltaWfwPkf
         37w/KdCKA5gau7xHNm0jXRNEDipWseFYG1KNjOseoplrAMBH033Ld9i8uhu2ZmrD/G
         oGc6ZpNbHJkKudwdiGmGI/63UY4Txt65sBndbXozpSFMSZRknNyOdeFKj93pI+kNb0
         GKeKBv01WK9mZbSC5szPlcCVPEVLi6z53bHeVSU3qWA2W3wFlo3Hk5oqmImvTWXzg1
         4xwCzUGe6H/OA==
From:   Will Deacon <will@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        marijn.suijten@somainline.org, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
        devicetree@vger.kernel.org, jamipkettunen@somainline.org,
        Rob Herring <robh+dt@kernel.org>, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: arm-smmu: Add compatible for Qualcomm SM6375
Date:   Tue, 19 Jul 2022 20:56:53 +0100
Message-Id: <165825146901.2951100.17739649475708755118.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220716193223.455859-1-konrad.dybcio@somainline.org>
References: <20220716193223.455859-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Jul 2022 21:32:22 +0200, Konrad Dybcio wrote:
> Add a compatible for Qualcomm SM6375's broken-as-usual MMU500 impl.
> 
> 

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/2] dt-bindings: arm-smmu: Add compatible for Qualcomm SM6375
      https://git.kernel.org/will/c/743302d4ad6c
[2/2] iommu/arm-smmu-qcom: Add SM6375 SMMU compatible
      https://git.kernel.org/will/c/ef660de424cf

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
