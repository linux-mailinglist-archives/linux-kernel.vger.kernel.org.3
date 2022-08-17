Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D2E596BF1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 11:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbiHQJRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 05:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiHQJRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 05:17:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88B16B8DC
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 02:17:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 573291FE77;
        Wed, 17 Aug 2022 09:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660727850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I/B2eXUmZ1muy3ZNR9dI48LMMOtZGNNRF+Mq92M7IjA=;
        b=NcKTGz94mD2uDswiSMU1bXxsK8/BpsJqOk04AtGtOqo31CTgcmowgMq1PhFAPc77CgT4y/
        V0A4Eso10+h9g++zhT5jOkyEa6ISx94H5JJ3BdkuwCLupNJU0zh426N/BtcViTiI+9M0k3
        bIor5uXp07zXSR9tmtQyzVj/uQ3N1mM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E80313A8E;
        Wed, 17 Aug 2022 09:17:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id glNqBiqy/GIEagAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 17 Aug 2022 09:17:30 +0000
Date:   Wed, 17 Aug 2022 11:17:28 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>, tj@kernel.org,
        gregkh@linuxfoundation.org, hannes@cmpxchg.org, kernel@openvz.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com, shakeelb@google.com,
        songmuchun@bytedance.com, viro@zeniv.linux.org.uk
Subject: Re: [RFC PATCH] memcg: adjust memcg for new cgroup allocations
Message-ID: <20220817091728.GA23229@blackbody.suse.cz>
References: <62188f37-f816-08e9-cdd5-8df23131746d@openvz.org>
 <45a04b75-d61b-4c7a-7169-c971995a6049@openvz.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <45a04b75-d61b-4c7a-7169-c971995a6049@openvz.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Wed, Aug 17, 2022 at 10:42:40AM +0300, Vasily Averin <vvs@openvz.org> wrote:
> However, now we want to enable accounting for some other cgroup-related
> resources called from cgroup_mkdir. We would like to guarantee that
> all new accounted allocation will be charged to the same memory cgroup.

Here's my point -- the change in the referenced patch applied to memory
controller hierarchies. This extension applies to any hierarchy that can
create groups, namely, a hierarchy without memory controller too. There
mem_cgroup_from_cgroup falls back to the root memcg (on a different
hierarchy).

If the purpose is to prevent unlimited creation of cgroup objects, the
root memcg is by principle unlimited, so it's just for accounting.

But I understand the purpose is to have everything under one roof,
unless the object lifetime is not bound to that owning memcg. Should
memory-less hierarchies be treated specially?

> +static inline struct mem_cgroup *mem_cgroup_from_cgroup(struct cgroup *cgroup)
[...]
> +	css = cgroup_get_e_css(cgroup, &memory_cgrp_subsys);
> +
> +	if (css)
> +		memcg = container_of(css, struct mem_cgroup, css);

Nit: mem_cgroup_from_css

Regards,
Michal

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCYvyyEwAKCRAkDQmsBEOq
uSCPAQCeYjJ/qm++P/4MyI2v/wOc/rxsPsDWD5iNCRSC8V4fgwEA5ul4VN0roAWb
w7p+yQKU1DsET1vl+iysCsdEjcDYywE=
=WPtl
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
