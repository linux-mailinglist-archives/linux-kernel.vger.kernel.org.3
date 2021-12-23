Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4091747E66E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 17:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349237AbhLWQfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 11:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244252AbhLWQfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 11:35:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7E5C061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 08:35:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14EE4B81FC3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 16:35:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196C7C36AE9;
        Thu, 23 Dec 2021 16:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640277351;
        bh=N390lWOZKv0lRWDpfux31O6R5ZTVe+v7Xb1rOr2jH1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eVj/7ERrDDmgNfY6pNuVHLBGnVI3edhEAFpe+OC1vB37o0WaNTW9R3noLiRp0Ik2U
         4dM8HNJZYTE1GYYeML2NOlFy4UKJM/OqEH6wCPwZOzchYe2P9jMfZmxCoEO4dKxkAw
         aPEqiARbma0yC0RAI3G26unf1d8SuqrlpaNBh+WXawo905UrnfedRsdFDdlWJnUkVq
         inpt+jbx2rR7ubpwX4DbcYVIVPQP6aWZfcr0rwonddiWmpjzz1qkA5FKDFmJuE9ZLw
         m6sT3VLNdrofefv7JiYMqO4Z3aQRwdEZj2ENmI1veSiZ+RzMYEYv1noo0QsR8ShE72
         hUHHkoeOsn1GA==
Date:   Thu, 23 Dec 2021 22:05:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH 7/7] soundwire: intel: remove PDM support
Message-ID: <YcSlZHN7B5hqpJRM@matsya>
References: <20211213054634.30088-1-yung-chuan.liao@linux.intel.com>
 <20211213054634.30088-8-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213054634.30088-8-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-12-21, 13:46, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> While the hardware supports PDM streams, this capability has never
> been tested or enabled on any product, so this is dead-code. Let's
> remove all this.

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
