Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B938657D5C7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbiGUVRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiGUVRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:17:36 -0400
Received: from luna (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net [86.15.83.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E4565D71
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:17:35 -0700 (PDT)
Received: from ben by luna with local (Exim 4.96)
        (envelope-from <ben@luna.fluff.org>)
        id 1oEdY2-001tWL-2b;
        Thu, 21 Jul 2022 22:17:30 +0100
From:   Ben Dooks <ben-linux@fluff.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux@armlinux.org.uk
Subject: some sparse fixes
Date:   Thu, 21 Jul 2022 22:17:26 +0100
Message-Id: <20220721211729.451731-1-ben-linux@fluff.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,FSL_HELO_NON_FQDN_1,
        HELO_NO_DOMAIN,KHOP_HELO_FCRDNS,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some small fixes for sparse warnings.


