Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB21506279
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 05:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346175AbiDSDJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 23:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346118AbiDSDJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 23:09:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844122DD4D;
        Mon, 18 Apr 2022 20:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SsJk7JK8mJoRcEXTenmsrGMKR0sbCwebkTrY6GmdZlg=; b=MKkF4Vkbg2Y77O3berH21bWVKV
        NWg3ioyM6TsXWS3wS5RZRpNDBE2INsNyooWOHrB3H/fyi2ocVxWBDKP3XFMukIEVR1zRLyGzhAIU9
        U2wNLMY3yDmKVY1HgL80LiMlaYoMhLkDbRYpzyZN3dZWdJ+vTUo29NsgsPnRPDiaZlq8wOW5jAh0e
        kZfA+Dbdq84SR3igCJ9upua184fxmfcp0GG/QMLRX5flchXTeqzksRff/iu5hjPrOezhigHJ5x05j
        XINGOLfYO6rhPcFkD4gadMbVzTBijuT1vynoK7G7UheC0l0q3d3zrxR1zduVJ/lquBKPwnMqeeKPW
        IJmOBQqA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngeCG-002jEl-4D; Tue, 19 Apr 2022 03:06:32 +0000
Date:   Tue, 19 Apr 2022 04:06:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Bruno Moreira-Guedes <codeagain@codeagain.dev>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
        Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Subject: Re: [PATCH 2/2] Docs: Update kernel series in changes.rst
Message-ID: <Yl4nOBlKnWIcGcYS@casper.infradead.org>
References: <cover.1650336366.git.codeagain@codeagain.dev>
 <a124c3c34e627c124673640aed177c10e401b052.1650336366.git.codeagain@codeagain.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a124c3c34e627c124673640aed177c10e401b052.1650336366.git.codeagain@codeagain.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 11:58:35PM -0300, Bruno Moreira-Guedes wrote:
> @@ -7,7 +7,7 @@ Intro
>  =====
>  
>  This document is designed to provide a list of the minimum levels of
> -software necessary to run the 4.x kernels.
> +software necessary to run the 5.x kernels.

We don't change the major version when we update the minimum required
tooling ... why not change this once and for all to say:

+software necessary to build the current kernel.


