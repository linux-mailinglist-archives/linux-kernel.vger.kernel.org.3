Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907BA496598
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 20:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbiAUT2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 14:28:39 -0500
Received: from linux.microsoft.com ([13.77.154.182]:42530 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiAUT2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 14:28:38 -0500
Received: from kbox (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 60EEC20B6C61;
        Fri, 21 Jan 2022 11:28:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 60EEC20B6C61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1642793318;
        bh=/IjvVe+TAlWpGlX1Ya04FOUEkm1N1TtyPsV2esSWls0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F16eZkbeBpCPVrnNfjayA2byk0xfZAqq7DFvEMhHrfRwBFuVPsrgzORMHRhdItHoM
         02Oadvjjh777I5fB2SrJ9YCiqNPGOy7P9fCAI8pu2uTfoO/01IIXgG+dXc6FN4LRb/
         x2hBCs6jyQBWdwmChIg1xSiQ0bTzMIgFze9ahlCo=
Date:   Fri, 21 Jan 2022 11:28:33 -0800
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 00/12] user_events: Enable user processes to create
 and write to trace events
Message-ID: <20220121192833.GA3128@kbox>
References: <20220118204326.2169-1-beaub@linux.microsoft.com>
 <20220119173203.7fb0cf37add3f7e6faeb7721@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119173203.7fb0cf37add3f7e6faeb7721@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 05:32:03PM +0900, Masami Hiramatsu wrote:
> Hi Beau,
> 
> Thanks for updating. This series looks good to me.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> for this series.
> 
> Regards,

Great! Thank you for all your time on this, I appreciate it!

-Beau
