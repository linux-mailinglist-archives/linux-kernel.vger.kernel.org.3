Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4355B4923B1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 11:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237210AbiARKUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 05:20:25 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:38872 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiARKUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 05:20:25 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 08AB71F3A1;
        Tue, 18 Jan 2022 10:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642501224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vyG09JjfHE/eqrhcJjMQf+/NgPWriznXEChHMp6Jkyg=;
        b=FzNmAfC0+l3AtP2VDl+AiZ3PH/Qc+RTOrcBPVZ1lFwujyYNdLOcEVPSTPpZAjMuuK84RQU
        qbYXKofgRH6AczvrOIVxbILHyDQ0KkowLwF5AEFjkn5yT+JcDT8Ou16aOb3+45VK2iH+Z+
        qG/ywoN0DuUN/pr4KnUy45vdHVo6HBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642501224;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vyG09JjfHE/eqrhcJjMQf+/NgPWriznXEChHMp6Jkyg=;
        b=QJdEss9/BNRTF5aIoqbXvudRe0jeV/+ulMorQ1TAdiC3dNZ4AcLuKdhQnlQPp0iDFuNgpY
        0T7oFe36rNDwVvCg==
Received: from suse.de (unknown [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C8741A3B81;
        Tue, 18 Jan 2022 10:20:21 +0000 (UTC)
Date:   Tue, 18 Jan 2022 10:20:19 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Bharata B Rao <bharata@amd.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        srikar@linux.vnet.ibm.com, riel@surriel.com
Subject: Re: [PATCH] sched/debug: Remove mpol_get/put and task_lock/unlock
 from sched_show_numa
Message-ID: <20220118102019.GS3301@suse.de>
References: <20220118050515.2973-1-bharata@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220118050515.2973-1-bharata@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 10:35:15AM +0530, Bharata B Rao wrote:
> The older format of /proc/pid/sched printed home node info which
> required the mempolicy and task lock around mpol_get(). However
> the format has changed since then and there is no need for
> sched_show_numa() any more to have mempolicy argument,
> asssociated mpol_get/put and task_lock/unlock. Remove them.
> 
> Fixes: 397f2378f1361 ("sched/numa: Fix numa balancing stats in /proc/pid/sched")
> Signed-off-by: Bharata B Rao <bharata@amd.com>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
