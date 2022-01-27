Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88DF949DAEC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 07:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbiA0Gkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 01:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbiA0Gk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 01:40:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D37C061714;
        Wed, 26 Jan 2022 22:40:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C1FAB8208E;
        Thu, 27 Jan 2022 06:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCB3C340E4;
        Thu, 27 Jan 2022 06:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643265626;
        bh=YCEQJOqamp76h+hodLfyNzMOia7mX3TnaRSEk+7aQeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YQV46Z+5EOLaDHiEdtXw3XUsks4cNbnXz3bfkbXzJEhN6tFHRcyr9EEoz4X/8/dBW
         nILAuwHxfjeQwZtula5DjDnqfF5ZEGTtcFscpAHaop4wx05cxBhmoQUJPuuhII++tg
         538KGKoIA8APnOTVDu68xeNOFGlE60F3wBTZjTzVz7MdQ8JR4DXFEqb2nRaBaiKIFK
         ZtTlPZabyh7MQSi1LUdkoYLlUM1GrjlSTu6F9aUrci1gteAsBebWPVT9JUGRlHxww6
         XS0f4Awcu2Vgzcymd+joAG0aS1nj/TUNrGDQZC/2w1hiqYrrqfu/1jX1l5gw22kDr7
         0fxNblMX/m+oQ==
Date:   Thu, 27 Jan 2022 12:10:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        ~okias/devicetree@lists.sr.ht, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: phy: convert Qualcomm USB HS phy to yaml
Message-ID: <YfI+VvBv4mP/5BlS@matsya>
References: <20211230000740.103869-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230000740.103869-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-12-21, 01:07, David Heidelberg wrote:
> Conversion of Qualcomm USB HS phy documentation to yaml.

Applied, thanks

-- 
~Vinod
