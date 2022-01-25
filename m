Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4257D49B62F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387881AbiAYOZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578575AbiAYOU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:20:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2660EC061756;
        Tue, 25 Jan 2022 06:20:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6A4F6158E;
        Tue, 25 Jan 2022 14:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6502AC340E0;
        Tue, 25 Jan 2022 14:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643120423;
        bh=/9wV3DdR6VIU1LSc/7b0h+AIfBB7qLQlUNUZwUz9jWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eMEERL17L3qALjy5zKR3OhyaS7Emkni9fYL+vHZViYhnIPXT5M9GiP+2+rX2ZkXwI
         DeICSx3AWT7ROn5tSK4j142QwPRTFSroObwNmpQwHJUfrYCwcAABdjg9tEssu1a8A4
         zuZqHosSX507s3cu8dGWiYn4tusyQ/K8VXTIwq630/o4jyLpnrpI+FowttGqzkrcqT
         DLFyfo3OVtrW8j9UK/WkdyI1rS8SSfS7vmM2WhZ6Ktg1963VeG5xiFPnCer8cjDuPS
         U8t+glyyCMIZrP7uOiu965zCrMZFrrgODlM/1/Cfe4m3C0P7UtObJdei3obBESvdmN
         eQGNyRYkBWbFg==
Date:   Tue, 25 Jan 2022 19:50:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8450: fix apps_smmu interrupts
Message-ID: <YfAHI7JH7ozteRf4@matsya>
References: <20220122162932.7686-1-jonathan@marek.ca>
 <20220122162932.7686-2-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122162932.7686-2-jonathan@marek.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-01-22, 11:29, Jonathan Marek wrote:
> Update interrupts in apps_smmu to match downstream. This is fixes apps_smmu
> failing to probe when running at EL2 (expects 96 context interrupts)

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
