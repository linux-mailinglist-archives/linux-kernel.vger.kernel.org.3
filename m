Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB2E545017
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343920AbiFIPDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244302AbiFIPDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:03:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6FB1912C5;
        Thu,  9 Jun 2022 08:03:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70FF5B82E08;
        Thu,  9 Jun 2022 15:03:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE14C34114;
        Thu,  9 Jun 2022 15:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654787026;
        bh=zckzmkd7x9TcLA6szScBpBDm6k+73RvLOocAbgUPcAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a7W0E9G+xCZRWgN4UtTdhxqKa8G0Ba1/siJ6zWbNERHwp+Sl2J9TFAO++MN0OCR2K
         Y81dQYGEQ8JFZ8f09NyzIFCucLLWvrDFXGaYtLUAuFPXTLUhuEbXZHeZ3NEd5eBA3n
         jV4VZwah8XPvduppXUXY824LY1z9grpwuioCxpu/CQswTZaFU3XRmSnyH5cYc3z+4i
         QNc80Cv2/GI0Rp8A1iNuGGoibchA8KIQdTxNbKeFndqaIKkqo5pKgFwNDEYoLnkWqb
         v3KRzCMy9UrMbYEkETmqovNdOdoAxeKj29YTa/wbygfs/94sejr+E9x3oiNWKjHypD
         9UnzGu+NwZpMQ==
Date:   Thu, 9 Jun 2022 16:03:39 +0100
From:   Will Deacon <will@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Akira Yokosawa <akiyks@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH -lkmm] docs/memory-barriers: Fix inconsistent name of
 'data dependency barrier'
Message-ID: <20220609150339.GA3289@willie-the-truck>
References: <cc2c7885-ac75-24f3-e18a-e77f97c91b4c@gmail.com>
 <20220607133432.GA32701@willie-the-truck>
 <Yp9h4Cmo0UNZp6xD@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yp9h4Cmo0UNZp6xD@rowland.harvard.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 10:34:08AM -0400, Alan Stern wrote:
> On Tue, Jun 07, 2022 at 02:34:33PM +0100, Will Deacon wrote:
> > Alternatively, maybe we should be removing the historical stuff from the
> > document altogether if it's no longer needed. We don't have any occurrences
> > of read_barrier_depends() anymore, so why confuse people with it?
> 
> How about relegating discussion of these barriers to a special 
> "historical" or "niche architecture" section of the document?  In a 
> separate patch, of course.

That would work, perhaps with a little bit of commentary to say that it's
no longer relevent to the kernel sources and is provided for information
only.

Will
