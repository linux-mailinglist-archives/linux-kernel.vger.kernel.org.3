Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E7B48535D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 14:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237101AbiAENTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 08:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237074AbiAENTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 08:19:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76142C061761
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 05:19:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1366D6170D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 13:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD8DC36AE0;
        Wed,  5 Jan 2022 13:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641388758;
        bh=+WwWNgnGqh9XKYRNXBRhQR5JlOjez82G+xx4+InuGTk=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=nnd1NXzGhmBCx2stpx6uM8DAuouE5BCINIPeMH9oYt8XOtqzqJyi2X9Zhhbp8ztlh
         L7Fr0inLESAUrye5qEw3i60fI2R4Cx0YEkN1aixSzFlfOGdRo2ZoFj31c735d8clTB
         Rqw5ReShkO92DUbHLjs4FrOEv87SR2YdSRyNu030IoIIAUhdl40Qt8DVMUdNdPdgI2
         nKl1tR8ELGcqzCgPixdRQ2UWolsIkL7UrnX5ETsI6ObIyaoisep7vCeYXsEdxDaW4i
         qR0cgopk6DMeX6Xt118mzP+SBAJx5LpdCmXu9+WNXX5j9vndmhCOtWnhGcZM6s0bIE
         Fj+dSffn4z0Gg==
Message-ID: <a2036978-81f9-fad4-90ce-15dadf048693@kernel.org>
Date:   Wed, 5 Jan 2022 21:19:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [f2fs-dev] [PATCH 3/6] f2fs: do not expose unwritten blocks to
 user by DIO
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220104212419.1879225-1-jaegeuk@kernel.org>
 <20220104212419.1879225-3-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220104212419.1879225-3-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/1/5 5:24, Jaegeuk Kim wrote:
> DIO preallocates physical blocks before writing data, but if an error occurrs
> or power-cut happens, we can see block contents from the disk. This patch tries
> to fix it by 1) turning to buffered writes for DIO into holes, 2) truncating
> unwritten blocks from error or power-cut.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
