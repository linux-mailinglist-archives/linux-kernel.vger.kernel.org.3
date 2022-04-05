Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D934F542A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 06:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240684AbiDFEhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 00:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348237AbiDEVJd (ORCPT
        <rfc822;linux-kernel+subscribe@vger.kernel.org>);
        Tue, 5 Apr 2022 17:09:33 -0400
X-Greylist: delayed 369 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Apr 2022 13:32:37 PDT
Received: from mail.wantyapps.xyz (unknown [66.135.5.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C1BE8876
        for <linux-kernel+subscribe@vger.kernel.org>; Tue,  5 Apr 2022 13:32:37 -0700 (PDT)
Received: from wantyapps.localdomain (bzq-109-64-27-34.red.bezeqint.net [109.64.27.34])
        by mail.wantyapps.xyz (Postfix) with ESMTPSA id D796E839DB
        for <linux-kernel+subscribe@vger.kernel.org>; Tue,  5 Apr 2022 20:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wantyapps.xyz;
        s=mail; t=1649190387;
        bh=2NGUGoBeJPZ/A1WnRklwB6yPj5s9Zuoi/XaFUYBDfmQ=;
        h=Date:From:To:Subject:From;
        b=gnpuG2P1GUHFJYgr4q5A9u+GNCfswE0LUb9kn+lknq5UGqOQpqpeX8q/IqvXGt0DG
         HpdbLufp9YRlGZjaDOnmovoRuty08RTL9WFwrF6m90JCep0XxQwEKnfcBWFlI8Gn+c
         Rc7gIbFhHtLjTsvdk9ZMKRIz3NTr29w9HjlV8Yd44j1sjnx1FDUQkVZn0yxRoK1Py9
         MOCkbtUTwqihsaxwPaZyI5s6VO4e/wArWHRIApKfpOKxxbICdtpualBnwqKZOqAYoh
         Tiz6lkYjlXciqh2/qtckDBy4/CN5pM2tNuAmqpTvL4z8tt2/5lRqAkA6HIv8IK+zsy
         sspyiBHBcithw==
Date:   Tue, 5 Apr 2022 23:26:21 +0300
From:   Uri Arev <me@wantyapps.xyz>
To:     linux-kernel+subscribe@vger.kernel.org
Subject: Subscription
Message-ID: <20220405202621.bz5fktmaxnlvehuz@wantyapps.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,PDS_OTHER_BAD_TLD,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is this the way to subscribe to this mailing list?
