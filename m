Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A0859A7AE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 23:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352438AbiHSVYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 17:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352412AbiHSVYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 17:24:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C3465653;
        Fri, 19 Aug 2022 14:24:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44A3EB8291D;
        Fri, 19 Aug 2022 21:24:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BA2C433C1;
        Fri, 19 Aug 2022 21:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660944272;
        bh=kL6OoZQzbZhCnpqAomEI5zbHnxYjN98/ass6PjENi9c=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=kOKBWDkKuNm1BeNBcK+JRXfdPi9DIaaekD9flrz9GZsjxGivgRjhC4LfrdL67eOYx
         Em3a+O6MApvNwiDuAJoA8y3HjMbHDzWrW7x0LdiyKZteNnpLARduyD8Ec93R+eGOfJ
         AyTLTuMoAQ7Dqpl5abYp2p2HevdfgwXmVUn9pNJUJ0PPz6gAt23JUoMwTdh3ddJta/
         8jZx+onPHlbvvj+Mu4J7yDNVfApDRDhWr0BT/b4sbsYd05Fn+doDk060uRHCOeklqR
         1rIcTL58YyvzuAqPDeT46CW2t262/ripvm1g2aPy5qv1ZbQxv18lydp88SC86LTfrv
         RM+DtTY/nJUTw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220617014308.4001511-1-windhl@126.com>
References: <20220617014308.4001511-1-windhl@126.com>
Subject: Re: [PATCH v4] clk: nomadik: Add missing of_node_put()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     windhl@126.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Liang He <windhl@126.com>, linus.walleij@linaro.org,
        mturquette@baylibre.com
Date:   Fri, 19 Aug 2022 14:24:30 -0700
User-Agent: alot/0.10
Message-Id: <20220819212432.03BA2C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Liang He (2022-06-16 18:43:08)
> In nomadik_src_init(), of_find_matching_node() will return a node
> pointer with refcount incremented. We should use of_node_put() in
> fail path or when it is not used anymore.
>=20
> Signed-off-by: Liang He <windhl@126.com>
> ---

Applied to clk-next
