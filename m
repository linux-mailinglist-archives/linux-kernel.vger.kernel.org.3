Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC2A5758AE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 02:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbiGOAnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 20:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGOAnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 20:43:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74B0491E3;
        Thu, 14 Jul 2022 17:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RL4a78mz5dcxQKx/h6CWF+hVgr1YJg/HzEyCO0H00p0=; b=22NYjQKf/yMyYzmGZS+w4AE+Si
        QWIN0PJWTS0QpXve8sbJkO78xFs08bKN4h8IyzRjvxXZR/Zj330AIV0AGaJHFTHtYygQtsKuwdF9O
        tEIcCX+PGoxEDFQalmE1gdQZ1f2fvbv9T9lSHw3U0p0ZJ4iXWfdDXkR9JViMkUwUM+5jFTh7FrTQ8
        k36845mcCcMWpj0NkIfqhpNMOCNty8riycMh2hBdDnbBRVAe9QjNglY0RGeAllUtgCZHrmyal4Qpa
        zgcXZ3p2Vtlve5aNQcQk1EFcJ11gdC7jf9ZW9efZIjUC35TLPOuRbooLnjQhVXtws5Tgh5dS7WJog
        DaD65xkQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oC9QL-002owg-Kw; Fri, 15 Jul 2022 00:43:17 +0000
Date:   Thu, 14 Jul 2022 17:43:17 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, atomlin@atomlin.com,
        oleksandr@natalenko.name, neelx@redhat.com
Subject: Re: [PATCH v2 0/3] module: Show the last unloaded module's taint
 flag(s)
Message-ID: <YtC4JWQqG8gOYlad@bombadil.infradead.org>
References: <20220714153933.2095776-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714153933.2095776-1-atomlin@redhat.com>
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

On Thu, Jul 14, 2022 at 04:39:30PM +0100, Aaron Tomlin wrote:
> Hi Luis, Christophe,
> 
> In addition to the previous iteration, since this particular series does
> indeed modify last_unloaded_module, I decided to use strscpy() as a
> replacement for the now deprecated strlcpy().

Nice, looks super clean now, applied and pushed to modules-next, thanks!
BTW since you and Christophe seem to contribute a lot to modules lately,
any chance for future stuff you can ask 0day folks to add your trees
and branches to get tested prior to posting patches? Then you can
suggest in your cover letter they've been blessed by 0-day or whatever.

Typically I push to modules-testing, wait and if no complaints come back
then I push to modules-next but in this case I just went to
modules-next directly as I couldn't see how this could break.

  Luis
