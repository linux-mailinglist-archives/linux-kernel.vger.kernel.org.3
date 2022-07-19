Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E29B5790A8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbiGSCNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235452AbiGSCN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:13:29 -0400
X-Greylist: delayed 103 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Jul 2022 19:13:29 PDT
Received: from mr85p00im-hyfv06021301.me.com (mr85p00im-hyfv06021301.me.com [17.58.23.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151443C8D9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 19:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1658196808;
        bh=T4xK7W1C8/EAKpZlNLBDLSvbQJQGFkNtPL6rJnWFjMw=;
        h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:To;
        b=XW+XIV//tMqRCxaRXgrZOG4XgQwZPK+W7wKzL7+Dy35AcPFoG9mxKwpdCbyeKVXl5
         qKwHqKel5iWnxQSS3J9M+xBGb2jYac2faa9szptgreLQT+rdOGwjrVPkeUsUQhIlts
         c9k6p2q1t/5Te11ANq50Twl5jF84LHs6W6crngk4eam2lqmVHNIERTe/JC9Rnlg6YQ
         Nhe9mo+U6/qy+GZh+i/+Ykk82hPhis/rvogT109JczZ1+QIoyStMdrp28BF38CDDvn
         M73+3ESe8BmDO7JaGFk50MUuLt0o1UPM7KWiLPBV6uT6BMZ+O93z5URnOUavPFMmvv
         Kg7xk490dXfsw==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
        by mr85p00im-hyfv06021301.me.com (Postfix) with ESMTPSA id 2E3AD21511E2;
        Tue, 19 Jul 2022 02:13:28 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Robin Naccari <robianna1973@icloud.com>
Mime-Version: 1.0 (1.0)
Subject: Re: SECCOMP_IOCTL_NOTIF_ADDFD race condition
Message-Id: <9DD7B896-9D48-4AD5-8894-C1D2AD055C36@icloud.com>
Date:   Mon, 18 Jul 2022 19:13:27 -0700
Cc:     alban@kinvolk.io, containers@lists.linux-foundation.org,
        gscrivan@redhat.com, jannh@google.com,
        linux-kernel@vger.kernel.org, sargun@sargun.me, tycho@tycho.pizza
To:     Robin Coley <naccarirobin@icloud.com>
X-Mailer: iPad Mail (19F77)
X-Proofpoint-ORIG-GUID: Fh7aNNNDE98HMSycqg0v8mvV6brheVn_
X-Proofpoint-GUID: Fh7aNNNDE98HMSycqg0v8mvV6brheVn_
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.816,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-18=5F01:2022-01-14=5F01,2022-01-18=5F01,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 clxscore=1011 spamscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=495 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2207190007
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=EF=BB=BF


Sent from my iPad=
