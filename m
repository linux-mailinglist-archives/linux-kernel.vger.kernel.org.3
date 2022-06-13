Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB76A548429
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 12:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240560AbiFMJxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240295AbiFMJxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:53:07 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03F7D92;
        Mon, 13 Jun 2022 02:53:06 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25D9gJ3S020604;
        Mon, 13 Jun 2022 04:52:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=NGC2Z2sscpSeQkxNL27luBtXi1J0TvS4+58h8uzMCak=;
 b=epPQcRnx4ouGRVPhpSqMsRjcaO8u+tX57ehE3mT+UpKQz54TYUxiZk6vepFvGHyqYUCH
 73fTDjHE/8f4OeZzPplnCXjY8cytnmlcVwYTOKdg/vYoRDdz858TML4iUJ58tj3uv87b
 ceiN2e51Xrmv3Lj38bpYdFhqTSRbckE57+LnmF1rOu0VV+SvCcVhTL2lZDmCuPPiN/3W
 +4ouBcOcqx8EuY2JAPj5eoOWOTJqSg2WMC8zq9yzfZo63wP44VzERstD13fEstlHF3pv
 u/UJ0LkVqABO4xAYp1Fhq9HI3w19Wgn2los633QtVDKoqR7ZIKTWKfw8u631tZW0y0sb VQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3gmqfq1qv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 13 Jun 2022 04:52:52 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 13 Jun
 2022 10:52:50 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 13 Jun 2022 10:52:50 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7039046C;
        Mon, 13 Jun 2022 09:52:50 +0000 (UTC)
Date:   Mon, 13 Jun 2022 09:52:50 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Joe Perches <joe@perches.com>,
        <linux-clk@vger.kernel.org>, Luca Ceresoli <luca@lucaceresoli.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: clock: Move lochnagar.h to
 dt-bindings/clock
Message-ID: <20220613095250.GA38351@ediswmail.ad.cirrus.com>
References: <20220613081632.2159-1-lukas.bulwahn@gmail.com>
 <20220613081632.2159-2-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220613081632.2159-2-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: UKe1Lc-PQs_M3STC455nabt6Y3fQj0bV
X-Proofpoint-GUID: UKe1Lc-PQs_M3STC455nabt6Y3fQj0bV
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 10:16:31AM +0200, Lukas Bulwahn wrote:
> Most of the clock-related dt-binding header files are located in
> include/dt-bindings/clock. It would be good to keep all the similar
> header files at a single location.
> 
> This was discovered while investigating the state of ownership of the files
> in include/dt-bindings/ according to the MAINTAINERS file.
> 
> This change here is similar to commit 8e28918a85a0 ("dt-bindings: clock:
> Move ti-dra7-atl.h to dt-bindings/clock") and commit 35d35aae8177
> ("dt-bindings: clock: Move at91.h to dt-bindigs/clock").
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
