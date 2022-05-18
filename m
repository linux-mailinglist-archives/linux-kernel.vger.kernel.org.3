Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF10452B26C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 08:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiERGZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 02:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiERGZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 02:25:06 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD993D4104
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YYsnIspLu+tOsQK7f99pgVP2zh9WSNhhrntR8lZ098Y=; b=TmJhfTUm6KxEcMLaLFaRy+x11D
        ZSPo1hVNNRPSxQep8HvYCm56XmoabLEXERGvQfNigehIHMEXbL/9eac8E8h5WFwNIa9fEqgRe2Jwg
        i0N70lgHBcIg/wT9mCZac2MBQxlgSmo1IMaVhrFJubI5P2CeWHLiZcmCA+B1+jBm57xL/CZSpY5SH
        e4U8mv7VeysBvpbMI7AtHsVcX4kvbjtbw3Yeh/XjfL0jzBwVIYFalpYqyAy3pD4nsri4uH+GaZqMc
        a8ECkKfVpk4awvWuD+jcLL/Z55O/HeJ9fddIRFwfRB8jsYorGi1oJVHTOrzp2xjHDBKZQOn7keLrV
        zBIDeJQQ==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrD7E-00FxuV-Fq; Wed, 18 May 2022 06:25:00 +0000
Date:   Wed, 18 May 2022 06:25:00 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     syzbot <syzbot+5b1e53987f858500ec00@syzkaller.appspotmail.com>
Cc:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in mntput_no_expire (3)
Message-ID: <YoSRPP1n26hmDuzn@zeniv-ca.linux.org.uk>
References: <20220517223806.2299-1-hdanton@sina.com>
 <000000000000be329205df3cf252@google.com>
 <YoQohxAFD3EPujRC@zeniv-ca.linux.org.uk>
 <YoRFAoe99ob/YzD5@zeniv-ca.linux.org.uk>
 <YoRHfB7lEGUwQBGU@zeniv-ca.linux.org.uk>
 <YoRS0L0ywSZkflq7@zeniv-ca.linux.org.uk>
 <YoR4XSN2fn2BjkXw@zeniv-ca.linux.org.uk>
 <YoR8yrgorv8QssX6@zeniv-ca.linux.org.uk>
 <YoSGDwu++m4/gCIK@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoSGDwu++m4/gCIK@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SCC_BODY_URI_ONLY,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git proposed-fix
