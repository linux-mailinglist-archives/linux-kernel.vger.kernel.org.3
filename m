Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BE348650B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 14:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239408AbiAFNOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 08:14:34 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47160 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiAFNOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 08:14:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B653B82120;
        Thu,  6 Jan 2022 13:14:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B14C36AE3;
        Thu,  6 Jan 2022 13:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641474871;
        bh=lYLBPgK4zRcMauDvyn9MdGvG6s2G8AWEPpFOQqHi4xs=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=eUsyh32dgTA4mL0V0kj/FxINolMYVMPGzBqtneqf/oqOhACpWBGXnOwkxHJmA2TRH
         FJ2lxjrxyi4K/PICsg7nDI6vDto1OhTbug4uLCwFVeJWS3k9t89b29ZrXYCoYoa9H0
         ZM9O9yGzbsPY86SpujsNfkp1L7r0/nqjmpUpN6env/Dv/7Z8Nd/EIi4a7U6JtSsEbl
         wz6jiubO2AHIhohQ4w5tfOJZM7MwJ3pJBQmrNmDsFplchXXlZa8HRWIVaRFoM1qMOd
         bZ4f54znAmO41lANnFUGF/RLPBT3+7dyOuqNSd4obqeDgXKq3ptmeka/ONNEJRhPbM
         HFwP8m7WuZ9Wg==
Date:   Thu, 6 Jan 2022 14:14:28 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, spbnick@gmail.com
Subject: Re: [PATCH 0/4] HID: hid-uclogic-params: Fix NULL pointer
 dereferences
In-Reply-To: <20220105172915.131091-1-jose.exposito89@gmail.com>
Message-ID: <nycvar.YFH.7.76.2201061414140.16505@cbobk.fhfr.pm>
References: <20220105172915.131091-1-jose.exposito89@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jan 2022, José Expósito wrote:

> Hi everyone,
> 
> This series fixes 4 possible NULL pointer dereference errors
> present in hid-uclogic-params.c found by Coverity.
> 
> Even though the fixes are small and very similar I made them
> in 4 patches to include the Coverity ID on each of them and
> make Coverity happy.
> 
> I didn't find any code calling the functions with invalid
> params, but since the check is there, it's better to make sure
> that it's doing its job.

Thanks, I've queued the series.

-- 
Jiri Kosina
SUSE Labs

