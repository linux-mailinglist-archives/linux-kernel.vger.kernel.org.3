Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE0A483EB0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 10:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiADJCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 04:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiADJCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 04:02:45 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B7AC061784
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 01:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=J8SP7NEN+hIuyqCL/eIlpbtF7g/pnX73KKsNuQiMtkU=;
        t=1641286965; x=1642496565; b=eT8NY9OgRq40r36gA7mJ2fP3x5SgfV5ZyaXT5LP8OPbvQQ3
        x1MkayR8VBGb3QphGRzEdszLrd1mj123t6bcyoxl3yq6y1SQmm9rA+Rwttt66OnDn3dW9B096tSyJ
        cByMtLZDpch8e1qY3fSi1JhALUuoVWazDhGP6zxbx3qEeRJ39aD218/H/1iYI2GLJmic4nUqqIomw
        iakmhDl5ZCbXLYy5/H4ISBNurbjIyzYJUUbm/GEyL4n4OjNPyhYdYkx6cx9yWOKppZvDEMVJ2Ox54
        qLcjO2Q46FjEdyvpGfERFeUq+Rr/b2zEUQ48QAbACPDT5if4ita5f9I5JhkRwJRg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1n4fiN-001hdT-25;
        Tue, 04 Jan 2022 10:02:43 +0100
Message-ID: <25e9d4e4f8655bee5dc5e8a017c83d743effa4e7.camel@sipsolutions.net>
Subject: Re: [PATCH 4/4] um: irq: Restore O_ASYNC upon exit
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, anton.ivanov@cambridgegreys.com
Date:   Tue, 04 Jan 2022 10:02:41 +0100
In-Reply-To: <20220101215810.13260-5-richard@nod.at>
References: <20220101215810.13260-1-richard@nod.at>
         <20220101215810.13260-5-richard@nod.at>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-01-01 at 22:58 +0100, Richard Weinberger wrote:
> Just like with O_NONBLOCK, make sure UML clears O_ASYNC
> upon exit when it set it.
> 

"when it set it" isn't really quite true - you always clear it, should
it be similar to the O_NONBLOCK version to see the old mode?

johannes
