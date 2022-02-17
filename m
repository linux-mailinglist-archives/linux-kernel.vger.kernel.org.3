Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8E24B9B8D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238241AbiBQIzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 03:55:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiBQIzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:55:37 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9B023969A;
        Thu, 17 Feb 2022 00:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pG7Jbh14O/ArEQAI0RCkDhTgqdhkfaQ0yOqhS+OJO+g=; b=bmlpzkMAeNHgY2by/P9LpWTfGS
        1ax4QgC1qumV/jED38eH+GeA10wQpY9ssKjo4C0HErLMhTiwEvoLQZvVKj1PTp53y0hoXHYQmNkdv
        BnkMC13IQvM+im/H8WziBGYZjize7u4rkTUgYr7Ka6+X4bTqywEl1mX7Hh2DCWptJzCE5TKQHuoY9
        SyQIJszkaL2raoiw3kWNdI5BUFP2hnYplxKaS9S1e1GTPur6QYYuZ/Fga8TtBQSyaLALJBxT3KIzd
        mbYBQcbEqT1qL71pzGeMsIPazMAJ+zMpY338ECEyQ5194h1pCMDugeWc7EAithNnw3sEdSFHG3SMO
        ZWavpW9A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKcZN-009cbi-Ej; Thu, 17 Feb 2022 08:55:21 +0000
Date:   Thu, 17 Feb 2022 00:55:21 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
        Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC V4 6/6] blk: export the sysfs for switching qos
Message-ID: <Yg4Necp/xHXWvoDM@infradead.org>
References: <20220217031349.98561-1-jianchao.wan9@gmail.com>
 <20220217031349.98561-7-jianchao.wan9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217031349.98561-7-jianchao.wan9@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 11:13:49AM +0800, Wang Jianchao (Kuaishou) wrote:
> -static const char *rq_qos_id_to_name(enum rq_qos_id id)
> -{
> -	return "unknown";
> -}

Please split the removal of dead code into a separate patch.
