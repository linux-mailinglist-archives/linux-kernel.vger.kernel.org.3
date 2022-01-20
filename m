Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA384948E6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 08:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240843AbiATHwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 02:52:42 -0500
Received: from verein.lst.de ([213.95.11.211]:43361 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230405AbiATHwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 02:52:37 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3E6E668AFE; Thu, 20 Jan 2022 08:52:34 +0100 (CET)
Date:   Thu, 20 Jan 2022 08:52:33 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: h8300 pull request for 5.14-rc?
Message-ID: <20220120075233.GA4777@lst.de>
References: <20210913054915.GA3631@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913054915.GA3631@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 07:49:15AM +0200, Christoph Hellwig wrote:
> Hi Yoshinori-san,
> 
> what happened to the h8300 pull request with the set_fs() removal that
> is in linux-next?

Given that we're at the end of yet another merge window:  what is the
status of the h8300 tree?  As far as I can tell the last pull request
was in July 2019, and it has commit since just after that.
