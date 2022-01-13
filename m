Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0D648DA7D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 16:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbiAMPJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 10:09:42 -0500
Received: from smtp1.axis.com ([195.60.68.17]:1281 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236061AbiAMPJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:09:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1642086581;
  x=1673622581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3XPWjsF5LGpUEnSsyCNLdqFmoDS2zGFxUmGf1VZVSyA=;
  b=LXv0YTaxqUVrrXblgr356kdk8zFQUvOYvitRBvbPsSeYWktPETd7s26m
   qTbh6q6D9NKCFhQbDSUvLpcbIL3eDShBg+JE+Z+ccGOb+GGygzbk0prNs
   tVCnp5Ba9Oa6RiVg8pUdkpLBCYj5J9/C5bD7Wl7IC/YtHuWOYsLkq+gtO
   TQ0GS4kxv2uqknzGSOYY8OIuPxQP3WdEM32dASdCql15+BD9JJGt6tvjE
   IGSSrzQNKE+KkeeVfIMWTtyPgJmpP84kUJekQeFqpBihEHu1jra5x5hrS
   kXc9pqmDhYMnbQoTv/rucup3pvHewiQ/+mj6yR0rxaD299KXkFDurGXZZ
   w==;
Date:   Thu, 13 Jan 2022 16:09:38 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>
CC:     "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@axis.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jdike@addtoit.com" <jdike@addtoit.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "richard@nod.at" <richard@nod.at>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] um: Document dtb command line option
Message-ID: <20220113150938.GA12384@axis.com>
References: <1118129237.194759.1640202076897.JavaMail.zimbra@nod.at>
 <20220104104457.282828-1-anton.ivanov@cambridgegreys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220104104457.282828-1-anton.ivanov@cambridgegreys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 11:44:57AM +0100, anton.ivanov@cambridgegreys.com wrote:
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> 
> Add documentation for the dtb command line option and the
> ability to load/parse device trees.
> 
> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>

LGTM, thanks.

Reviewed-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
