Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3585819E5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 20:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239607AbiGZSnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 14:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239592AbiGZSna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 14:43:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB6E2E9D0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 11:43:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E79E61479
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 18:43:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B007CC433D6;
        Tue, 26 Jul 2022 18:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658861008;
        bh=sreUVyE9ppDuXnjP81p7zZ1LfReeWdkHQsPd/epETp0=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=BSVUJcLbvu//IIi/zagybNsaeUgOkhbx8l36gqE0z+UyAq5NF7KKax6jlJ3G6EV+5
         jUVqdc3aq7TFQGo0CENmhTIn+aa5kly9lQF1kaOrd4XDgRLslrT5Bl6n8Q69RpnC9B
         k6zTAPA0THZay+ugM8eX+SVm22FepTpXNflYAoDob26K/qfqeL/KPwvcq52IrO5zWH
         kTQFIzRChmVpA/aKTRbkfpzlzxdEuAiy8nzgtU+R7opcVQb33wr/h+CMX2cgdrNjnh
         O6Pyt65Q+2uNcQynrWdofY9H9X50/IEZzSkZIn9xCFKtckAgGRXVnlbtEl3/UZ0tHF
         h1alxYCpvQ4Zg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 58BDE5C0B07; Tue, 26 Jul 2022 11:43:28 -0700 (PDT)
Date:   Tue, 26 Jul 2022 11:43:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Tag for upcoming nolibc pull request
Message-ID: <20220726184328.GA3404553@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I have pushed out a signed nolibc pull request tag "nolibc.2022.07.27a"
on the -rcu tree, as shown below.

Please let me know if I should make changes to the tag's title or body.

If I don't hear otherwise by Friday morning (July 29th), Pacific Time,
I will use this tag for my nolibc pull request to Linus.

As always, thank you all for your nolibc work!

							Thanx, Paul

------------------------------------------------------------------------

tag nolibc.2022.07.27a
Tagger: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue Jul 26 11:26:51 2022 -0700

nolibc pull request for v5.20 (or whatever)

This branch provides nolibc updates, perhaps most notably improved testing
via the "cd tools/include/nolibc; make headers" command.  This should
be considered a smoke test.  More thorough testing is in the works.
-----BEGIN PGP SIGNATURE-----

iQJHBAABCgAxFiEEbK7UrM+RBIrCoViJnr8S83LZ+4wFAmLgM6UTHHBhdWxtY2tA
a2VybmVsLm9yZwAKCRCevxLzctn7jOrgD/sFQzRgKVS2v3/rb+9IyIqwuCrniSBe
e7SLfteLNg3e02jMX/eVwx/X6D3C6Weg1ucLG/v0liyPV3ODiX/cSJK48q7wBnOR
/TNtBEvtBsoY7LNORf53qAm3x//fCTTdw2qlkWM6RXcmeR0NH/PWfcas2hRJYhl8
hwkQaC9j2CcOLxgN75RcbOsmnV6x+CtLJkH/k2DlfHpnwoO953uyeG0wCAWzNzQn
yFr3PXjOaJd2qNCPNsdMGpjush9tp+fm2E9gXiDj+vk49MWNgoM/nWQe/p7GB5V9
YWKEMudpVbkxXvT6EFj+ctGS7RVvYYnhjicZvVEkZEtszx3muQLcuSOE+p9KQ7v+
mRGyzvhNu7ZyhMSZWA1Qf5pqiu6L3XTp672RMsYcP4keqN5kC/A5hbNt8qGybEPg
PXaQVZQpV15z7gluEM8FhUPbUL3J9PZsTgwPEzjgt3lyDdmE+KszHQCSD/UyN//8
WZJ/gwweQeTtLz/U+i2dGiT5tWjQ8sWg32AobzbylkyX7D1qDqUu0GYai8dPfbWO
y7vbn9IB+uL1c2MFiO3jJkYCY7UoGESNd2j0SFdNPWnZee5FeXht3SIHaqMOhnqF
Oguigt5SUd3/jh5dzMgQPahAH0tKm1n/+W7jBi2ieV1Lz4dKpS8xjMhmmT+D/SaT
M7C8+63JeQwY8A==
=sLEE
-----END PGP SIGNATURE-----
