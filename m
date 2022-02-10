Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4D04B03C8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 04:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbiBJDLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 22:11:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiBJDLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 22:11:07 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033711EADA;
        Wed,  9 Feb 2022 19:11:05 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JvMFx5MqJz4xNq;
        Thu, 10 Feb 2022 14:11:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644462663;
        bh=HhwzvjUPFOHcfTaUVO3reaBZB3EluQb3+ihWWVYoB6M=;
        h=Date:From:To:Cc:Subject:From;
        b=IWRaTSEesgFXQmJ5XGATfqyU1XIxi6fFIwqDrrOpKMedMpqSt+jyFcjls3vlHIB84
         Tnt01TTgH+ToZXC2uybsll5J/uRLsZiFjX3qPq9J1YSpkqRJ85mSlvQpb4ALpP6HRm
         +0xgY8OWOmvqA6yLIHrzcWGCWRTUkyx1JfZn2vAkaRxuh5HG7styL1JQ6aZvA+GS07
         BGw0By85Yy6r/jBmq1tvVey+1hDwDYn/sVYXo4CC6tAh0GrIZqNPyx6BZi75Srjh1r
         hrIK5HGlgUc0JI/6QCdGYobJNu4Xs/R+/wycEauc3Q9h1gp9F30Xp2dI8LMKoIBLJx
         YzwBhqOarzpSw==
Date:   Thu, 10 Feb 2022 14:11:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Andy Gross <agross@kernel.org>
Cc:     Baruch Siach <baruch@tkos.co.il>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sean Anderson <sean.anderson@seco.com>
Subject: linux-next: manual merge of the usb tree with the qcom tree
Message-ID: <20220210141100.715b13e9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YE.fFeUQoG8J/iLi_.2UNHn";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YE.fFeUQoG8J/iLi_.2UNHn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the usb tree got a conflict in:

  arch/arm64/boot/dts/qcom/ipq6018.dtsi

between commit:

  d1c10ab1494f ("arm64: dts: qcom: ipq6018: fix usb reference period")

from the qcom tree and commit:

  5726079cd486 ("arm64: dts: ipq6018: Use reference clock to set dwc3 perio=
d")

from the usb tree.

I fixed it up (I just use the latter) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/YE.fFeUQoG8J/iLi_.2UNHn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIEgkQACgkQAVBC80lX
0Gxv4Qf+M440FlJjIjS7fNvueMdoewWOe36p64leRAxj6cP7TswLy638UJwesZqf
qdDYpyb+LDD5I+CcbLJzP4+GLg6zUwpnBAKFTZyTcvrvvZoEqFWM7R+e4+5MsllN
m17+uxiQSbkx/9OUOL19geSRKE4aajgzIAKrdAATWBK33NVmujH/XM18wfEqMmFg
5SzYjC+hJ5JNxXatQcnqDJHkv5QDZg3Mhtp9wrCZBzwX6kTvU/6zOSu1VAm61hBd
Wsu2hz++vO8C0LsjBBEf2uGgChYRBNgzYu5OVFZWso7B+sURkzhzVXFl4bNH6BwM
fIlivIvhjjzVpIC/ivVtCWUOTFWVRA==
=w/YA
-----END PGP SIGNATURE-----

--Sig_/YE.fFeUQoG8J/iLi_.2UNHn--
