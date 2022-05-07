Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC7051E3E4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 05:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445445AbiEGEDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 00:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiEGEDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 00:03:02 -0400
X-Greylist: delayed 1805 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 May 2022 20:59:16 PDT
Received: from slot0.crystalscrop.com (slot0.crystalscrop.com [194.31.98.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CD958E49
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 20:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=dkim; d=crystalscrop.com;
 h=Reply-To:From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding; i=info@crystalscrop.com;
 bh=vdtJwgFshmVn/X31MyHPWvuCG4o=;
 b=a7TP6aKr+1lbioqnHZAQak4VpxLPYmQPyDaF7OOYR0gGjY3z9MEnYNxBUYoQQyCs9MIsIlhBqDv3
   jt93pnL1Oo9GTFPeHLyZcPXjXekkuA2B72731q3OKfvnOf9hry7Pb0+QmPzN1zEsnAYyvbPprbhp
   s04fLUc70xqKPc8ZGM1Ep7IIH6Bgefa8jBbNs8pq5ak3r/p89OhOBmJAAy0Fdzetnaj9Q3hpThTo
   0rHp4ye2W4YFkE1hu4Uz1wveR6eC4K21R8udoNMPxBWhswIAJQzye2h2oIzJFE2mqCc3sFcKH0Qx
   ZqNTtkO3mCxtrm38sB+wye0Q4wA0hJBBci7ShQ==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=dkim; d=crystalscrop.com;
 b=Fofo6KYRClGnfhcR8hdxp7HIwVmO5xHtV+Y7FaGqWvKUx3HISwiZMwn0effwIZ2hgwxJi9IDs/sG
   sJRHw3ONOXBhJaV2/nn0THx1q80FlhYntnfWl4WMfpWCxD/cawbl2sjt40YB18VB/4XCzYQltl8R
   0gHKoHZEg1DfwClr6eXC5cuFER0AIS6Apd9HacFuNp/Zgw/A8gsh9uyOEwxMHjDgtmfC7MaI6OtZ
   cEgA2uv6+cRhf8b8q6xM0fjRPbuPmMHFWyNLZ3kZcVM+occpxmHglzMe7D5ECZmESx/C5rOSJIPa
   fHWheqau9d/fENsJo+Mp6OjHaldvL9s6NDiOwA==;
Reply-To: info@riitter-sport.com
From:   "Alfred" <info@crystalscrop.com>
To:     linux-kernel@vger.kernel.org
Subject: INQUIRY
Date:   6 May 2022 20:29:05 -0700
Message-ID: <20220506202905.C66B95773E2E7622@crystalscrop.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.7 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_MISSPACED,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_CSS_A,
        URIBL_DBL_MALWARE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  2.5 URIBL_DBL_MALWARE Contains a malware URL listed in the Spamhaus
        *       DBL blocklist
        *      [URIs: crystalscrop.com]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [194.31.98.191 listed in zen.spamhaus.org]
        *  0.1 URIBL_CSS_A Contains URL's A record listed in the Spamhaus CSS
        *      blocklist
        *      [URIs: crystalscrop.com]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.9142]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 FROM_MISSPACED From: missing whitespace
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings sir/madam


Alfred Eugen Ritter and Clara Ritter, n=C3=A9e G=C3=B6ttle founded the=20
chocolate and confectionery factory at Innere Moltkestra=C3=9Fe in the=20
Stuttgart district of Bad Cannstatt and the first cornerstone for=20
Ritter Sport's chocolate history was laid - this was where the=20
first "Ritter" chocolates were made and sold.

We have got your contact from our Agent and we are in need of=20
your product as we wish to establish a business relationship with=20
your humble firm.
Kindly provide us with your updated catalog and prices for our=20
preview.
Please indicate your payment terms for our review.
We will get back to you with order details


Alfred T. Ritter
Executive Purchase
https://www.ritter-sport.com
E-MAIL: info@riitter-sport.com
