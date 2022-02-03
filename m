Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85924A8A8A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353056AbiBCRpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:45:35 -0500
Received: from namei.org ([65.99.196.166]:45372 "EHLO mail.namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353037AbiBCRpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:45:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.namei.org (Postfix) with ESMTPS id 1E7A3550;
        Thu,  3 Feb 2022 17:32:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.namei.org 1E7A3550
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=namei.org; s=2;
        t=1643909520; bh=rAToLpJ9j5wm8/nb+ZGZarEFzMzYoiLtdSdu0m6dzio=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=KRMbjF6pcWNt22WdMkYdWE4aiS6hA6LGwq+c9gSCVrg7yb4wjlY6jLo3cVWsulj7T
         S9v4a/wRZw9KO0DCOj4Zn5mEIZOcqTgOtcYjTb7XtJqYZqCCRWhKJLara2x9c9Z2ov
         WRlHFnYxIJG3x+szAtsI0SyovbzlsjwI+ssw/6+o=
Date:   Fri, 4 Feb 2022 04:32:00 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     "Andrew G. Morgan" <morgan@kernel.org>
cc:     linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH] proc: add SecBits field to /proc/<PID>/status
In-Reply-To: <20220131051558.77127-1-morgan@kernel.org>
Message-ID: <d3fc9d9-d99e-a5ab-10a4-7cc60c97e1e@namei.org>
References: <20220131051558.77127-1-morgan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jan 2022, Andrew G. Morgan wrote:

> Securebits strongly influence the way Capabilities work for a process,
> make them visible in the proc status files.

My concern is that this might break some existing userspace code which 
parses the status file.


-- 
James Morris
<jmorris@namei.org>

