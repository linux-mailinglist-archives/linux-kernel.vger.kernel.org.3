Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09851584C16
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 08:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbiG2Gk0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 29 Jul 2022 02:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbiG2GkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 02:40:22 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C149C627D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 23:40:19 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6FBA862B9C58;
        Fri, 29 Jul 2022 08:40:17 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id B24J7QcZI7-N; Fri, 29 Jul 2022 08:40:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0A21D609D2FA;
        Fri, 29 Jul 2022 08:40:17 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id g81mKFyezKmO; Fri, 29 Jul 2022 08:40:16 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id CC0BA62B9C58;
        Fri, 29 Jul 2022 08:40:16 +0200 (CEST)
Date:   Fri, 29 Jul 2022 08:40:16 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
Cc:     anton ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Johannes Berg <johannes.berg@intel.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1107008566.40580.1659076816646.JavaMail.zimbra@nod.at>
In-Reply-To: <53bdf85f-8c29-7843-7ccd-88432e66b282@uni-rostock.de>
References: <20220607112714.516408-1-benjamin.beichler@uni-rostock.de> <53bdf85f-8c29-7843-7ccd-88432e66b282@uni-rostock.de>
Subject: Re: [PATCH v2] um: read multiple msg from virtio slave request fd
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: read multiple msg from virtio slave request fd
Thread-Index: tyQYcR4RU+a9DWDt4EhvYRC9x+B7YA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Benjamin Beichler" <Benjamin.Beichler@uni-rostock.de>
> Are there any issues with that patch?
> I would be happy to receive any comments or an acceptance :-D

Johannes, can you please have a look?

Thanks,
//richard
