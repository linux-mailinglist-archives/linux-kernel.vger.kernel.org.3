Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4326150F9DB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244867AbiDZKPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348675AbiDZKP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:15:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C0413DDB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 02:38:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D283EB81D3C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF85C385AC;
        Tue, 26 Apr 2022 09:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650965936;
        bh=FdzOrQvu6++ib5497R4Q/t3fH8Hdc4IvABGbNTHGKD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v+MU+Cjd4eesuiIinuoZTHr+o7j2+bx94ceCitEXGWDobcfG+sszcaZdghJhMwptr
         Er7AkoVhe/hjOp/o4en29iCBis3I2920BLtqGqeXRY4yeRSMcOF7LO4STOWZ7R8cqq
         rQFvfAawxhOEI1nlpye5MtJBEEGghYp2lHC0SQsI=
Date:   Tue, 26 Apr 2022 11:38:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] staging: vt6655: Replace MACvReadMIBCounter with
 VNSvInPortD
Message-ID: <Yme9rVZfELAECY7Z@kroah.com>
References: <cover.1650784817.git.philipp.g.hortmann@gmail.com>
 <2a50f3e99b15db2100f93e1e1a2b5cbc13b82882.1650784817.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a50f3e99b15db2100f93e1e1a2b5cbc13b82882.1650784817.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 09:44:11AM +0200, Philipp Hortmann wrote:
> Replace macro MACvReadMIBCounter with VNSvInPortD.
> Last patch within this patch series will replace all macros
> VNSvInPortD with ioread32. The names of macros and the arguments
> use CamelCase which is not accepted by checkpatch.pl

No need to say "last patch" as that will not make sense when these are
in the tree, right?

> 
> Since there are more than one checkpatch issue per line,
> more steps are rquired to fix.

This sentance also is not needed.

So the changelog can just say:

	Replace macro MACvReadMIBCounter with VNSvInPortD and as it was
	the only user, it can now be removed.

Same comments on the other changes in this series, but I did take the
first patch, it made sense on its own.

thanks,

greg k-h
