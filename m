Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57750525C3C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377690AbiEMHLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 03:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiEMHL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 03:11:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CA62EA24;
        Fri, 13 May 2022 00:11:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA80061ED9;
        Fri, 13 May 2022 07:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10969C34100;
        Fri, 13 May 2022 07:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652425887;
        bh=IW0lVa2ye/pD/vmsXD4u9wgZeVqrrjSpYDBsxZfka0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rhzvVE8CcQgZuzfBfjAJ4LedLEHg8UGBQqHBSZRS68AK5kj4NXBGU34pDRkNT+uh1
         nqQLI7igjHsVzNx/UL4sA3CwhhQd45cxnWOoTsTqwN3P0DpcLBxhDLJj/8uKGVr1hO
         CvVfMxTZwHoC8dR2jq44Ar6N8Ln8+Njd8FV10OedPvJD+L52JrrrzHDG3jd6GCpGR9
         s4gjYiCFM/2iWo99+AuzpYr7XLz4br17DKoqpfi9IoLZVt61DJf6GVSBJKckAac4LH
         u1q6z9G293mVAIpM4P/jfoNCE/5l8mfHTAYs6jFrIPvnJwIy98ef9REdSvJoiov93P
         XkGd/IpBJh8cA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1npPSN-0006fZ-II; Fri, 13 May 2022 09:11:23 +0200
Date:   Fri, 13 May 2022 09:11:23 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] serial: fsl_lpuart: Remove unnecessary clearing for
 CRTSCTS
Message-ID: <Yn4Em6VtV9rwWjnT@hovoldconsulting.com>
References: <20220511101139.5306-1-ilpo.jarvinen@linux.intel.com>
 <20220511101139.5306-5-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220511101139.5306-5-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 01:11:38PM +0300, Ilpo Järvinen wrote:
> if (termios->c_cflag & CRTSCTS) guarantees that CRTSCTS is not ever set
> in the else block so clearing it is unnecessary.
> 
> While at it, remove also one pair of extra parenthesis.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Johan Hovold <johan@kernel.org>
