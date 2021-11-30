Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCD046411B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344756AbhK3WRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:17:12 -0500
Received: from mail.netfilter.org ([217.70.188.207]:52008 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344780AbhK3WOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:14:23 -0500
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 8F7A7607C3;
        Tue, 30 Nov 2021 23:08:45 +0100 (CET)
Date:   Tue, 30 Nov 2021 23:10:58 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/netfilter: remove useless type conversion to bool
Message-ID: <Yaahcsu5c3noMnP8@salvia>
References: <20211124021801.223309-1-bernard@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211124021801.223309-1-bernard@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 06:18:00PM -0800, Bernard Zhao wrote:
> dying is bool, the type conversion to true/false value is not
> needed.

Applied, thanks
