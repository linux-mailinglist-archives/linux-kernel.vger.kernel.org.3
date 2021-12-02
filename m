Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD4B466131
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 11:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356713AbhLBKMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 05:12:15 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36172 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237551AbhLBKMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 05:12:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC4D5B82250;
        Thu,  2 Dec 2021 10:08:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A519C00446;
        Thu,  2 Dec 2021 10:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638439729;
        bh=IuWGJaDCjFa8PsnRrVCp3/5cjpCR1EyGvz9DJWIbWqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S0wH0S0l7ePBKqSRRXZYnzIU+QWkTR9Sc7v9ZOpc3jikhFQSh1v4hfyizQ8Sfpy+5
         t+XrxeShiwuuLS36AlXDGygFjm8upLguYEqKXYB5+7wk1FeMCgJDj9eLiBW9TRy7N4
         ac7yBVO0MrwliQw1bn6VmDaILGNfrZsx3E4N9IiOYmdBZb2BbkGBc6YXgmnq4tacdm
         UXdKT5ojyNRSl/Z7/Lczsbq1bGqxo/2CwlKzDelFFHVWJfsF5Op4UwwPrIQPfn7r5g
         aAzuXN6AKXuRnesVPhTBcTXWIeduGDHnaU+Ozh01KUrSAuntdPi+1lOowBl04IaV8D
         p4tF7OsBQ5QHQ==
Date:   Thu, 2 Dec 2021 10:08:44 +0000
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        chinwen.chang@mediatek.com, nicholas.tang@mediatek.com,
        james.hsu@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] arm64: update PAC description for kernel
Message-ID: <20211202100843.GB26450@willie-the-truck>
References: <20211201034014.20048-1-Kuan-Ying.Lee@mediatek.com>
 <Yaiat4ee0igTZDB5@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yaiat4ee0igTZDB5@FVFF77S0Q05N>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 10:06:47AM +0000, Mark Rutland wrote:
> On Wed, Dec 01, 2021 at 11:40:10AM +0800, Kuan-Ying Lee wrote:
> > Remove the paragraph which has nothing to do with the kernel and
> > add PAC description related to kernel.
> > 
> > Suggested-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
> 
> This looks good to me.
> 
> Catalin/Will, did you want to pick this, or do you want Jonathan to do so?

I can grab it.

Will
