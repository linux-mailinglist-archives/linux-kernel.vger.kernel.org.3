Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF63526897
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 19:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382570AbiEMRkM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 May 2022 13:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379077AbiEMRkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 13:40:10 -0400
X-Greylist: delayed 83421 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 13 May 2022 10:40:08 PDT
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2BDB9289BD;
        Fri, 13 May 2022 10:40:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id 7B5CDFFCE9;
        Fri, 13 May 2022 17:40:06 +0000 (UTC)
Date:   Fri, 13 May 2022 19:40:03 +0200
From:   Max Staudt <max@enpas.org>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] can: drop tx skb if the device is in listen only
 mode
Message-ID: <20220513194003.10f72402.max@enpas.org>
In-Reply-To: <20220513153606.302464-1-mailhol.vincent@wanadoo.fr>
References: <20220513142355.250389-1-mailhol.vincent@wanadoo.fr>
        <20220513153606.302464-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_20,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From my view (I don't have the big picture here), this series looks good
to me. Thanks!


Max
