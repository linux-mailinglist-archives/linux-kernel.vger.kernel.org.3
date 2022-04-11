Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1B34FC1A5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348341AbiDKP6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348339AbiDKP5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:57:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B858167DB;
        Mon, 11 Apr 2022 08:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y0SNVmMp7H+ptzmcsyoUL9pL/AxP4E97rpWB6EyeD1c=; b=czjs/J+XQMI6TDlpo4/BBukBpN
        auEAxmc22XkER3cO4nYXuZiOEJtQlbN/p9JcMHEXBRcgJ5OqIAuaya1uuzslGsX9pOUESzZwOMm4q
        ACSUDQiIqSME6pwKTJvU97wA0PtcsVUHf1KfHV4qzOn5K4XpT35HFXr+jnMWjE8CWbmZOw4Eq26nW
        SuNseXXNIWRXEB19iV328Vpu6yCxEvM5zF/WMWgbflo/QoMaITcIA6lhZTzwIuKwAFgPI16Gm1pzk
        0gbmPdNhWL3Ga2XWblrbLHU4gxLnURyPoaBo5IufXQZy0ortUwcrU7d3oPwKgcsLzgZgmOCks5upi
        SoDGAu8A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndwNr-009gN7-VV; Mon, 11 Apr 2022 15:55:20 +0000
Date:   Mon, 11 Apr 2022 08:55:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] init: print some info about UUID and LABEL in
 name_to_dev_t()
Message-ID: <YlRPZy+trbDdanyh@infradead.org>
References: <1649475581-12139-1-git-send-email-yangtiezhu@loongson.cn>
 <1649475581-12139-2-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649475581-12139-2-git-send-email-yangtiezhu@loongson.cn>
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

On Sat, Apr 09, 2022 at 11:39:39AM +0800, Tiezhu Yang wrote:
> If there is no valid initrd, but root=UUID or root=LABEL is used
> in the command line, boot hangs like this:

There is no root=UUID or root=LABEL handling in the kernel at all, so
I don't see why we should print anything here.
