Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E15C517CA4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 06:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbiECEpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 00:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiECEpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 00:45:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47613E0CB;
        Mon,  2 May 2022 21:42:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 180C4CE1D9F;
        Tue,  3 May 2022 04:42:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951D7C385A9;
        Tue,  3 May 2022 04:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651552935;
        bh=u9fYNrygbkpprqV6eu/t6XuhVbfYeFBJ+xDghRxaGi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VmsRjzvEPKjcA8PzCqOGBOAoRGRrGd97jANpbZ+MGsou/tGrt7rjS34H6IufKx6Z8
         S9CIjnX6enCjz04qxIMIjYLw9yTdLldjRk1PG0Lbppsmihn28qWeHsiEDzTkp5+T94
         JVmQoznXp0APHJXy7fK+y0bhCSMgfEyMJhRbRiuaETstJ+ufSAsXTFmU52Tnmaqoe4
         jaf52g14YiTM5e1boySQeWCcvVj47sAn3r0Ho0RzQtMs7mNOq1e3q0D5AM87q6Gd1w
         v6qvCbXbT0o1SI/QaQBy/OY+denC8F3gO8R2ApT/d4T4J8Nq/fTRteCs+oakRFG+MB
         ANC6LmqYTEZ0A==
Date:   Tue, 3 May 2022 10:12:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] phy: qcom-qmp: pipe clock fixes
Message-ID: <YnCyojDt2N+Enhs2@matsya>
References: <20220502133130.4125-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502133130.4125-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-05-22, 15:31, Johan Hovold wrote:
> This series fixes a pipe clock imbalance on PHY power-on failures and
> renames some error labels in order to improve readability and avoid
> future bugs in the same category.
> 
> Both patches can be applied for -next.

Applied, thanks

-- 
~Vinod
