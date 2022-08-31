Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FCF5A8046
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiHaOeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbiHaOdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:33:51 -0400
X-Greylist: delayed 3904 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 Aug 2022 07:33:48 PDT
Received: from ufbdcsli.oaxial.com (unknown [194.87.134.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920CCA3D0A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 07:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=dkim; d=oaxial.com;
 h=Content-Type:MIME-Version:Content-Transfer-Encoding:Content-Description:Subject:To:From:Date:Reply-To:Message-ID; i=aiz.mil@oaxial.com;
 bh=Sihr77LhFvV+FQxPXIMEvV7ks4M=;
 b=D8D0T8oMpN53HcnFfxRQKVYP14ZQLGEgYFgxJN1IWxsvJYIj5Iq0tFsHPmQ/gpin7vakjsw2plWu
   7RHEDiMmsDKSUEaPaqEj5wV9YS8j42TnxBDXzikiR7PG0nYoY+iC0STKNn0Il8fqSfWqvcwDtg+k
   4VAU5RK3lIHznOwZNEl1camHqEjF/RjTYxXHVRX3O04D5A34RY2SYDLlxHPTMU9+RlhIAg4DfLnY
   xOc2AHE7A1L+dmyYR/AjyAE6lMSySsJeFEl+ZyuBYMDjcAwvCQLhofaSZfNLxZXXXU1jJHDNcQ/V
   dxGVodN7tTrPxqGfNuTpwK60EYEmnCVW/FHVXg==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=dkim; d=oaxial.com;
 b=tRl2fhtRxoaktuP58XxoY8ljCnQXeyKUxqT8upIAr9Wu2uzWhqzcIr/yzGwJwtgBmq48OJ8sZ2rs
   4USqvgKtpfI+8KEaCUkl0lcZfZBJSGipnidEdS4ogEFQRmcqGICk9TLAst0Z8UuG6Vhsy0FpKHuo
   CShNPn6iI5KhTuxEpQ14Fhak1N9YIlET/xOLYg8OhRHmgrekTIXFJe2YWfqAYa9qRSgKvDKu0hGk
   rIjQVNXNOOkIhL0PDfvkeNDPUU5BhFTyMVmWNrRshWT8Ww6To156NfZHGDFEKZsueOojIWSfzSAF
   KSZRwcV5nDeNnq5Ru/WDnDNQ01MI9pgEswNUuA==;
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Dear Friend
To:     linux-kernel@vger.kernel.org
From:   "Iris Plain Eagle" <aiz.mil@oaxial.com>
Date:   Wed, 31 Aug 2022 06:28:40 -0700
Reply-To: irisplaine@gmail.com
Message-ID: <0.0.2A.333.1D8BD3D95A1A134.0@ufbdcsli.oaxial.com>
X-Spam-Status: Yes, score=7.3 required=5.0 tests=BAYES_80,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8724]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.8 RDNS_NONE Delivered to internal network by a host with no rDNS
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My name is Iris Plain Eagle from Canada. I would like to discuss something =
very important with you, Kindly respond to enable me send you more details.

Thank you and God bless.

Iris Plain Eagle
E-mail : irisplaine@gmail.com
