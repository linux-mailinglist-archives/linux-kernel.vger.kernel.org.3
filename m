Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB4A5A5823
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiH2Xs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiH2XrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:47:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3229C2CD;
        Mon, 29 Aug 2022 16:46:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EECA361419;
        Mon, 29 Aug 2022 23:46:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99459C433C1;
        Mon, 29 Aug 2022 23:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661816800;
        bh=9ER5wun+g5QxP30lyOeyIxQBsJ50x1pAqroEcoW55VM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VaO+k/FjG9COOuskaRCPmTZmfbH8WEqXuF2hD54SeaSlKMeTcYBID8memRg+pk+IS
         Livc9MnjGYUiRo2jDxS8MkV5UOa5sCkB3KWYCmzeeg9nPIuFJKXBcYRKuiY4fFTtDo
         APA5hH/50AA1sTjENO18mgpIlFALcld2jhswzSwqa8tdIjMC9H+o15Z36P1Lv+V6B9
         6ih2AdhRVod8kAxqsYywJuA0xSDXKbwOhLVB/f/joAEyQqZ+6klffCA2rnT5P0ikWd
         0qidYc/DFeuD2DgbIX+KWSWjbsAQLPjYursl6fRuH82t+VjuufpnMDovkc7vKIxKKE
         Tp6Hqtr0Ay5xw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, luca.weiss@fairphone.com
Cc:     robh+dt@kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        phone-devel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: pm6150l: add missing adc channels
Date:   Mon, 29 Aug 2022 18:46:02 -0500
Message-Id: <166181675977.322065.12641252369185465571.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220812114614.1195679-1-luca.weiss@fairphone.com>
References: <20220812114614.1195679-1-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Aug 2022 13:46:15 +0200, Luca Weiss wrote:
> Add the missing adc channels and add pre-scaling property to die_temp
> channel, as per downstream dts.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: pm6150l: add missing adc channels
      commit: ed3163b02a2c37744566d19fc451e6687aa2205d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
