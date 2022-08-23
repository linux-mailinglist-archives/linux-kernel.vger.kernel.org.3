Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B916C59E1AA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357976AbiHWLkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 07:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348213AbiHWLdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 07:33:23 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16405C6CD5;
        Tue, 23 Aug 2022 02:27:00 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27N8PGXE022459;
        Tue, 23 Aug 2022 09:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=2vei+MS82V0X3c1p2oKJzYV81h4jfWZJXKgnSJtOV3M=;
 b=S6EfbDBsKbuAylSq63HeJxvjxh75ADg29RzhwkY2QP957FAdZQkq+XJKOdVa+oggyprv
 Km+xxVie6X7gxU24DoCmmwdK5s+tVaos38I/1wIObASUbACaQwx1Ttfi67SM1TULx5+U
 2YOcoF2DKPuyLkhup561ZpjMfM+EF7SGjNTHjifB239Wp4R5vsmNOugefHMufjSiuLBD
 H4WqGbN9Ym9+Jp/FVdshN0yDDfFNuXlOONmHebh+apIYk33/QylzGcqSNAvEeIm06+xz
 yXfzhPbrvKqpDbh73njwAGY773yXFLt8pdwTquGqqUm4LiWyHub70X42UijSzM2lCwuD NA== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j4uc99q0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 09:26:56 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27N9LTvw012628;
        Tue, 23 Aug 2022 09:26:54 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 3j2q88tkhu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 09:26:54 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27N9QpWQ32113070
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Aug 2022 09:26:51 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 423FF5204F;
        Tue, 23 Aug 2022 09:26:51 +0000 (GMT)
Received: from osiris (unknown [9.145.80.88])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id E75155204E;
        Tue, 23 Aug 2022 09:26:50 +0000 (GMT)
Date:   Tue, 23 Aug 2022 11:26:49 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com
Subject: Re: [PATCH v2] perf list: Add PMU pai_crypto event description for
 IBM z16
Message-ID: <YwSdWUt02SFzrMUm@osiris>
References: <20220804075221.1132849-1-tmricht@linux.ibm.com>
 <YvOq3B02x8GqkVPA@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YvOq3B02x8GqkVPA@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HhpzBzzd8F6ifxvoDAMc2tTnzIpJa4jm
X-Proofpoint-GUID: HhpzBzzd8F6ifxvoDAMc2tTnzIpJa4jm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-23_04,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208230035
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 09:55:56AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Aug 04, 2022 at 09:52:21AM +0200, Thomas Richter escreveu:
> > Add the event description for the IBM z16 pai_crypto PMU released with
> > commit 1bf54f32f525 ("s390/pai: Add support for cryptography counters")
> 
> What tree is this? I tried on torvalds/master:
> 
> ⬢[acme@toolbox perf]$ git remote update torvalds
> Fetching torvalds
> ⬢[acme@toolbox perf]$ git log --oneline -1 torvalds/master
> d4252071b97d2027 (torvalds/master) add barriers to buffer_uptodate and set_buffer_uptodate
> ⬢[acme@toolbox perf]$ git show torvalds/master d4252071b97d2027 | head -5
> commit d4252071b97d2027d246f6a82cbee4d52f618b47
> Author: Mikulas Patocka <mpatocka@redhat.com>
> Date:   Tue Aug 9 14:32:13 2022 -0400
> 
>     add barriers to buffer_uptodate and set_buffer_uptodate
> ⬢[acme@toolbox perf]$ git show torvalds/master 1bf54f32f525 | head -5
> fatal: ambiguous argument '1bf54f32f525': unknown revision or path not in the working tree.
> Use '--' to separate paths from revisions, like this:
> 'git <command> [<revision>...] -- [<file>...]'
> ⬢[acme@toolbox perf]$ git log --oneline torvalds/master | grep "pai: Add support for cryptography counters"
> ⬢[acme@toolbox perf]$
> ⬢[acme@toolbox perf]$ git show torvalds/master d4252071b97d2027 | head -4
> commit d4252071b97d2027d246f6a82cbee4d52f618b47
> Author: Mikulas Patocka <mpatocka@redhat.com>
> Date:   Tue Aug 9 14:32:13 2022 -0400
> 
> I'm applying it locally so that it gets included in testing, but please
> clarify where is that 1bf54f32f525 cset.

Thomas mixed up our non public development tree and Linus' tree.
Correct commit id + subject are:

39d62336f5c1 ("s390/pai: add support for cryptography counters")
