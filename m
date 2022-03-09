Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D98F4D28B3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 07:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiCIGJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 01:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiCIGJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 01:09:52 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165AED4C82;
        Tue,  8 Mar 2022 22:08:50 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C6D3B68AFE; Wed,  9 Mar 2022 07:08:46 +0100 (CET)
Date:   Wed, 9 Mar 2022 07:08:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-raid <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: raid5 bio handling cleanups
Message-ID: <20220309060846.GA31216@lst.de>
References: <20220228112503.841449-1-hch@lst.de> <CAPhsuW7EGxoyc9dkpP0y9AUWrV5V6ZORhew+tX=rFXS+vRm_AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW7EGxoyc9dkpP0y9AUWrV5V6ZORhew+tX=rFXS+vRm_AA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 04:14:40PM -0800, Song Liu wrote:
> On Mon, Feb 28, 2022 at 3:25 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Hi Song,
> >
> > this series cleans up the raid5 bio handling to take advantage of
> > the bio allocation interface changes in Jens' for-5.18 branches.
> 
> Applied to md-next. Thank

Unless I'm missing something these did not make it into the pull
request to Jens, right?
