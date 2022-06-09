Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EF85442A2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 06:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237846AbiFIE1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 00:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237606AbiFIE1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 00:27:41 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9546F65A1;
        Wed,  8 Jun 2022 21:27:39 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 58A8F6732D; Thu,  9 Jun 2022 06:27:36 +0200 (CEST)
Date:   Thu, 9 Jun 2022 06:27:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Michael Schaller <misch@google.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New partition on loop device doesn't appear in /dev anymore
 with kernel 5.17.0 and newer (repro script included)
Message-ID: <20220609042736.GA31823@lst.de>
References: <CALt099+y4-kJ0OqVeKaAjAbs4inOkR-WE0FmyiJRDc1-Ev9UKw@mail.gmail.com> <20220603124956.GA18365@lst.de> <CALt099JqRXwsGnq_DmHmnwPyB0K9Y+-BZUG_YoGxOg7G7ZZh9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALt099JqRXwsGnq_DmHmnwPyB0K9Y+-BZUG_YoGxOg7G7ZZh9w@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 03:21:28PM +0200, Michael Schaller wrote:
> Could this patch also be backported to 5.17 and 5.18?

I've sent the backports now.  Any chance I could trick you into submitting
your reproducer to blktests:

   https://github.com/osandov/blktests

?
