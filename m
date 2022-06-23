Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FDA5578EE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbiFWLp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiFWLpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:45:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81004CD43;
        Thu, 23 Jun 2022 04:45:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 761C9B8225F;
        Thu, 23 Jun 2022 11:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B829C3411B;
        Thu, 23 Jun 2022 11:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655984749;
        bh=Ww7Wzcwqkp/dbEVh53zEn2lZhTl1P3ZAgZnVdLZgCKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nb3KUAX9+KYCTRqU54XnUS7e6eu3ZtZQi5Xgv0UjdUPJJNTl6KAHEydLqh6w0wY9u
         lsFgLs1FRvGJWzb9x/tNHJnhfSR1t7aLxknQhme9PnPTxVueVCSl7PvZaakz35Dayv
         h3s+b/KsXHxUZDZGjnDVa9PzYWo/atINutJjIKDzVSU2yII4pRaaAV1IlQ4ZyXCi8w
         gx8CyuVday+bY3OAFIO/Da6d8cZW/0OxBYKgDqGFCIeMHapUNj9Uty31/ImanHNe5a
         FukM0RMC7K4wVmT0nOEfS6C2ZZzGiSlosQ5fy9s6mKc/Ma/3lCBuXOTs0BBuq7e2FE
         gahiWZ22LXQnA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o4LHN-0007pp-CT; Thu, 23 Jun 2022 13:45:45 +0200
Date:   Thu, 23 Jun 2022 13:45:45 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] phy: qcom-qmp: clean up defines
Message-ID: <YrRSabGuRDRy8bi3@hovoldconsulting.com>
References: <20220609120338.4080-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609120338.4080-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 02:03:35PM +0200, Johan Hovold wrote:
> Here are some trivial cleanups of the QMP defines for issues found while
> adding support for SC8280XP.

> Johan Hovold (3):
>   phy: qcom-qmp: clean up v4 and v5 define order
>   phy: qcom-qmp: clean up define alignment
>   phy: qcom-qmp: clean up hex defines

Any comments to these, Vinod?
 
>  drivers/phy/qualcomm/phy-qcom-qmp.h | 70 ++++++++++++++---------------
>  1 file changed, 35 insertions(+), 35 deletions(-)

Johan
