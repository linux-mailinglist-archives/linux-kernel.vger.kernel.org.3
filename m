Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E84B570A57
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 21:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiGKTH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 15:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiGKTH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 15:07:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7A33C153;
        Mon, 11 Jul 2022 12:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=cTu89TVLQe5sVZxuoRK/bvJzYAZBu3zq2kHeOyYopDE=; b=o6UfKiaQurEfXif/77ctq7M2f7
        BWN9C1gee8kBAchwjgXiOctQAakxNWMNxHtRs0eYUCQviL/K0uUqw0FPS5lidP+8f5bn86XKfpKt4
        ayBQpF7U9sGKNbPmgBeQWuZOdt7+zrSqhu83WccnsvMnj/y7mdZnZNbsgi5IsycVH1IQ46OSSd8CY
        rKAj5Lj65Gas8gJBDzQYOBhDCOU5yEgfT06Iy5tofaq+uMc5Ptk672wzkSLQMJWqcnkKi+NyYquGR
        0HDHtmgyUaGxQyP6JDeRcDIDyLoJGzfwGK/l52abLeA+ixBr+9Vf7CEKvmbEGGMYJ1+2kXVLqLw7Z
        hPn80RsA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oAyl9-0048tx-CQ; Mon, 11 Jul 2022 19:07:55 +0000
Date:   Mon, 11 Jul 2022 12:07:55 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "atomlin@redhat.com" <atomlin@redhat.com>
Subject: Re: [PATCH] modules: move module symbols from init/Kconfig
Message-ID: <Ysx1C9IkJiFL+OH5@bombadil.infradead.org>
References: <20220711162049.761342-1-mcgrof@kernel.org>
 <74dcc785-f3e7-6832-9af3-e0a0f69c58c9@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74dcc785-f3e7-6832-9af3-e0a0f69c58c9@csgroup.eu>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 06:33:08PM +0000, Christophe Leroy wrote:
> 
> 
> Le 11/07/2022 à 18:20, Luis Chamberlain a écrit :
> > This moves all the module symbols from init/Kconfig to its
> > own dedicated file now that we have all of the module code in
> > its own directory.
> > 
> > This does not introduce any functional changes.
> > 
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> 
> It is similar to the patch I sent in February, isn't it ? 
> (https://patchwork.kernel.org/project/linux-modules/patch/4042712961d42186c449734c253511ea7076c780.1645543105.git.christophe.leroy@csgroup.eu/)

Sorry, I had missed that. Can you send a new v2 based on today's
modules-next? And I'll just drop my patch?

  Luis
