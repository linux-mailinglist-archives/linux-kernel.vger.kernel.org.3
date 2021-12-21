Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4BF547BD18
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236498AbhLUJoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:44:20 -0500
Received: from mout.gmx.net ([212.227.15.15]:50853 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231744AbhLUJoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:44:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1640079849;
        bh=AZK43wksrM2wxHIkl5cyRC6Fgr2iNJ5TbwfvVa1YYws=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=jlAweLdeCY0OSHB2HLixBNDMxlZkW5O3Zc2aT2PwflGTT++W1xyp4kK/ttH6NzcC+
         fIzvgnO383odtby1N0JUIWc6QScZ624cbaW4yQryLlIAaU89HPzS+++GNJyuMCkW5f
         khglAu310NMwSBZxW6oWP2qA3zuNpR9r54bqXV54=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.148.137]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVN6j-1msDoF3kql-00SOTB; Tue, 21
 Dec 2021 10:44:08 +0100
Message-ID: <e7e282eeb90627d0d2a379ebb24b345675693a48.camel@gmx.de>
Subject: Re: [rcf/patch] netpoll: Make it RT friendly
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        RT <linux-rt-users@vger.kernel.org>
Date:   Tue, 21 Dec 2021 10:44:08 +0100
In-Reply-To: <aefb739c62186636cdc48e4fa7b78d31bdb21e75.camel@gmx.de>
References: <20211118163405.adczki7ibk22bw7e@linutronix.de>
         <773fd8246a1ec4ef79142d9e31b8ba4163a0d496.camel@gmx.de>
         <YboSe4NfbCeoqF1j@linutronix.de>
         <254513dc01188ca3ff161fcb456bc96a610821a1.camel@gmx.de>
         <YbyX2gAsLFrq+mMG@linutronix.de>
         <aefb739c62186636cdc48e4fa7b78d31bdb21e75.camel@gmx.de>
Content-Type: multipart/mixed; boundary="=-EMOGJgoEdB0ZDbEu42Hk"
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
X-Provags-ID: V03:K1:ytXCceYd81pcfnFRYXAFprfmxAkFZrUI7YiiWkus+rfO6TMgvsE
 t36nFMlQtyKmjFmKVNcT3GykY8pCLdyqj9+tCPU1rBZO78+xQH1F6px+wHlBptrJHEspzsG
 gbpPjPWOqge1sG+za4oV6GyEQb0TgEIjlQW0XzEmT3vctV4qCjej705NokhiqNCgNd86mrG
 TCxvFPPzDBphZJ2waA3Jw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:G7s5GkQYr+U=:Kt2Pe4ut9NYzPJeWHPWbfi
 Oi1FhZ9bTSJ+24h7/hTmQdhlm/0TdHg/+iH9PCYCFBJ3oTK5gu3TN1h2Chkdz6qIt7O/50v0w
 JAoBha4Z4z6ihICcUUqo2pR9/O8ixL8/Gtpmhr29Reap7RWWcqtlwWYDplmdMAWSyckQgb1Wu
 EFqyZ+SeDV1zWH2WwP2CPZNgztp7ONk7CAOCcteMAZzh4O5/yDfiPIsjZKu7V3r1ZP3Xa/uVJ
 80+fwvBvw8CIUZKAeWdE6syutjeqqc6THBvsSwZiiOCEQRRnO1zasF3Dpjzx3Om9uKnIjHbxu
 JkjPL2AZ6usqD26Cd8WI5mkliuk2PeGk3FVOhtHPiPevWyfGZSuRN+pEahYtj7chPyF+dvFXA
 QwPKf0JHnB4hOXjij3AUZNZKsXSc6/lVHH4Ls+/NLJHUGUGeOjMGbOpGw2dLO/WeTS6dnuvQU
 zqeFi66LXQD8yPTUBjuMbYdp174BT+XpkdPc9t3Kv6g3ANak+09oYdIw6+elrU61ddWDjM3sb
 VtMcrhYdu52/N2/Ta6TH5T0LthyVdg/VTDfQxBSpER9X0loz0QlU5xuuR8aefp+ie56RuVEsk
 fSlNIVd01Eng5S0xzgbxxlURhfe841V+RZXWIBKlP9BorIMOfqZfkn3I2pfnLE41uquUMcpbT
 Mhy0AEOuQFB2jQODE/uwGJeFFDGy1Ib3dM/0rCul4MHLokEOjX24akp5ntCW270OZxECruMQd
 Bgb1Btf58477zXGpsNrOM7BUAtU2KSIVZBAfIyXvlSrfABfhI/LvyoSdaYOIOW7MfiGQPMeen
 Ty2c4mXmvf39BgvEuOqbYm4KNf2q6S2URjmNTom1opgPZJS+mB/Pftm5fex3B9HiND2KYcCnn
 canOp2iaxm4370/Zy+tfgWaoAWvgHe/n28eqf4iL+31nd2UfdGJfOPqBOR0Yupp6T4lkDXS96
 A2njva/s/HPw0M19pCaM6l5JojM/jjV/OCLejJOJKlZ1wdt8/6QVwTQSQGNMuKwE/BmqRNiwH
 BJ9Wkm+TsY13cN01PR/q7bFfR+4vzwS7nprvkJyUPIpFqwSZju3FjttnEnZTrXpb2+wvKImFm
 VXxSuOmxQYTPZk=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-EMOGJgoEdB0ZDbEu42Hk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2021-12-17 at 17:41 +0100, Mike Galbraith wrote:
> On Fri, 2021-12-17 at 14:59 +0100, Sebastian Andrzej Siewior wrote:
> > On 2021-12-15 20:54:40 [+0100], Mike Galbraith wrote:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 In fact, I had already taken the sile=
nce as a "Surely
> > > you jest" or such.
> >
> > No, not really. netpoll is currently the least of my worries and I
> > wanted to finish my other network patches before I start wrapping my
> > mind around this in case something changes. But I have currently no id=
ea
> > how to do netpoll run/ detect and so on.
>
> I was gonna toss a rock or two at those "and so on" bits since they're
> wired into stuff my box uses regularly.. but I've yet to find a means
> to make them be more that compiler fodder, so they're safe.

Nah, I was just insufficiently bored.

It's surprising that patchlet worked at all with netpoll_tx_running()
being busted, but whatever, bridge now does its forwarding thing for RT
and !RT, transmitting twice per kmsg, though apparently only 1 actually
hits copper to fly over to console logger. See attached trace. Note
that for that trace I sabotaged it to alternately xmit via fallback.

This will likely end up being done differently (way prettier), but what
the heck, it beats a lump of coal in your xmas stocking.

	Ho Ho Hum :)

	-Mike

netpoll: Make it RT friendly

PREEMPT_RT cannot alloc/free memory when not preemptible, making
disabling of IRQs across transmission an issue for RT.

Use rcu_read_lock_bh() to provide local exclusion for RT (via
softirq_ctrl.lock) for normal and fallback transmission paths
instead of disabling IRQs. Since zap_completion_queue() callers
ensure pointer stability, replace get_cpu_var() therein with
this_cpu_ptr() to keep it preemptible across kfree().

Disable a couple warnings for RT, and we're done.

v0.kinda-works -> v1 feedback fixes:
    remove get_cpu_var() from zap_completion_queue().
    fix/test netpoll_tx_running() to work for RT/!RT.
    fix/test xmit fallback path for RT.

Signed-off-by: Mike Galbraith <efault@gmx.de>
=2D--
 include/linux/netpoll.h |    4 +++-
 net/core/netpoll.c      |   44 ++++++++++++++++++++++++++++++++----------=
--
 2 files changed, 35 insertions(+), 13 deletions(-)

=2D-- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -89,9 +89,11 @@ static inline void netpoll_poll_unlock(v
 		smp_store_release(&napi->poll_owner, -1);
 }

+DECLARE_PER_CPU(int, _netpoll_tx_running);
+
 static inline bool netpoll_tx_running(struct net_device *dev)
 {
-	return irqs_disabled();
+	return this_cpu_read(_netpoll_tx_running);
 }

 #else
=2D-- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -70,6 +70,27 @@ module_param(carrier_timeout, uint, 0644
 #define np_notice(np, fmt, ...)				\
 	pr_notice("%s: " fmt, np->name, ##__VA_ARGS__)

+DEFINE_PER_CPU(int, _netpoll_tx_running);
+EXPORT_PER_CPU_SYMBOL(_netpoll_tx_running);
+
+#define netpoll_tx_begin(flags)				\
+	do {						\
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT))	\
+			local_irq_save(flags);		\
+		else					\
+			rcu_read_lock_bh();		\
+		this_cpu_write(_netpoll_tx_running, 1);	\
+	} while (0)
+
+#define netpoll_tx_end(flags)				\
+	do {						\
+		this_cpu_write(_netpoll_tx_running, 0);	\
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT))	\
+			local_irq_restore(flags);	\
+		else					\
+			rcu_read_unlock_bh();		\
+	} while (0)
+
 static netdev_tx_t netpoll_start_xmit(struct sk_buff *skb,
 				      struct net_device *dev,
 				      struct netdev_queue *txq)
@@ -102,7 +123,7 @@ static void queue_process(struct work_st
 	struct netpoll_info *npinfo =3D
 		container_of(work, struct netpoll_info, tx_work.work);
 	struct sk_buff *skb;
-	unsigned long flags;
+	unsigned long __maybe_unused flags;

 	while ((skb =3D skb_dequeue(&npinfo->txq))) {
 		struct net_device *dev =3D skb->dev;
@@ -114,7 +135,7 @@ static void queue_process(struct work_st
 			continue;
 		}

-		local_irq_save(flags);
+		netpoll_tx_begin(flags);
 		/* check if skb->queue_mapping is still valid */
 		q_index =3D skb_get_queue_mapping(skb);
 		if (unlikely(q_index >=3D dev->real_num_tx_queues)) {
@@ -127,13 +148,13 @@ static void queue_process(struct work_st
 		    !dev_xmit_complete(netpoll_start_xmit(skb, dev, txq))) {
 			skb_queue_head(&npinfo->txq, skb);
 			HARD_TX_UNLOCK(dev, txq);
-			local_irq_restore(flags);
+			netpoll_tx_end(flags);

 			schedule_delayed_work(&npinfo->tx_work, HZ/10);
 			return;
 		}
 		HARD_TX_UNLOCK(dev, txq);
-		local_irq_restore(flags);
+		netpoll_tx_end(flags);
 	}
 }

@@ -243,7 +264,7 @@ static void refill_skbs(void)
 static void zap_completion_queue(void)
 {
 	unsigned long flags;
-	struct softnet_data *sd =3D &get_cpu_var(softnet_data);
+	struct softnet_data *sd =3D this_cpu_ptr(&softnet_data);

 	if (sd->completion_queue) {
 		struct sk_buff *clist;
@@ -264,8 +285,6 @@ static void zap_completion_queue(void)
 			}
 		}
 	}
-
-	put_cpu_var(softnet_data);
 }

 static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
@@ -314,7 +333,8 @@ static netdev_tx_t __netpoll_send_skb(st
 	/* It is up to the caller to keep npinfo alive. */
 	struct netpoll_info *npinfo;

-	lockdep_assert_irqs_disabled();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		lockdep_assert_irqs_disabled();

 	dev =3D np->dev;
 	npinfo =3D rcu_dereference_bh(dev->npinfo);
@@ -350,7 +370,7 @@ static netdev_tx_t __netpoll_send_skb(st
 			udelay(USEC_PER_POLL);
 		}

-		WARN_ONCE(!irqs_disabled(),
+		WARN_ONCE(!IS_ENABLED(CONFIG_PREEMPT_RT) && !irqs_disabled(),
 			"netpoll_send_skb_on_dev(): %s enabled interrupts in poll (%pS)\n",
 			dev->name, dev->netdev_ops->ndo_start_xmit);

@@ -365,16 +385,16 @@ static netdev_tx_t __netpoll_send_skb(st

 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 {
-	unsigned long flags;
+	unsigned long __maybe_unused flags;
 	netdev_tx_t ret;

 	if (unlikely(!np)) {
 		dev_kfree_skb_irq(skb);
 		ret =3D NET_XMIT_DROP;
 	} else {
-		local_irq_save(flags);
+		netpoll_tx_begin(flags);
 		ret =3D __netpoll_send_skb(np, skb);
-		local_irq_restore(flags);
+		netpoll_tx_end(flags);
 	}
 	return ret;
 }



--=-EMOGJgoEdB0ZDbEu42Hk
Content-Disposition: attachment; filename="trace"
Content-Type: text/plain; name="trace"; charset="UTF-8"
Content-Transfer-Encoding: base64

IyB0cmFjZXI6IG5vcAojCiAgIG5ldGNvbnNvbGUuc2gtNDA0MSAgICBbMDA1XSAuLi4uLi4uICAg
MTg5LjgwMjY5NDogbmV0cG9sbF9zZXR1cCsweDUvMHg0NjA6IHN0cnVjdCBuZXRwb2xsICpucDpm
ZmZmODg4MWVlYTdmMTI4CiAgIG5ldGNvbnNvbGUuc2gtNDA0MSAgICBbMDA1XSAuLi4uLi4uICAg
MTg5LjgwMjcwNjogX19uZXRwb2xsX3NldHVwKzB4NS8weDI0MDogc3RydWN0IG5ldHBvbGwgKm5w
OmZmZmY4ODgxZWVhN2YxMjgsIHN0cnVjdCBuZXRfZGV2aWNlICpuZGV2OmZmZmY4ODgxMDRjMGEw
MDAKICAgbmV0Y29uc29sZS5zaC00MDQxICAgIFswMDVdIC4uLi4uLi4gICAxODkuODAyNzA3OiBf
X25ldHBvbGxfc2V0dXArMHgxNjUvMHgyNDA6ICFuZGV2LT5ucGluZm8gPT0+IG9wcy0+bmRvX25l
dHBvbGxfc2V0dXAoKQogICBuZXRjb25zb2xlLnNoLTQwNDEgICAgWzAwNV0gLi4uLi4uLiAgIDE4
OS44MDI3MDg6IF9fbmV0cG9sbF9zZXR1cCsweDUvMHgyNDA6IHN0cnVjdCBuZXRwb2xsICpucDpm
ZmZmODg4MThjNzMzMTgwLCBzdHJ1Y3QgbmV0X2RldmljZSAqbmRldjpmZmZmODg4MTA3ZGU4MDAw
CiAgIG5ldGNvbnNvbGUuc2gtNDA0MSAgICBbMDA1XSAuLi4uLi4uICAgMTg5LjgwMjcwODogX19u
ZXRwb2xsX3NldHVwKzB4MWNiLzB4MjQwOiAhbmRldi0+bnBpbmZvIGFuZCAhb3BzLT5uZG9fbmV0
cG9sbF9zZXR1cAogICBuZXRjb25zb2xlLnNoLTQwNDEgICAgWzAwNV0gLi4uLi4uLiAgIDE4OS44
MDI3MDg6IGJyX25ldHBvbGxfc2V0dXArMHg0Yi8weGEwIFticmlkZ2VdOiBfX2JyX25ldHBvbGxf
ZW5hYmxlKCkKICAgbmV0Y29uc29sZS5zaC00MDQxICAgIFswMDVdIC4uLi4uLi4gICAxODkuODAy
NzA5OiBicl9uZXRwb2xsX3NldHVwKzB4NjkvMHhhMCBbYnJpZGdlXTogcmV0dXJuOjAKICAgbmV0
Y29uc29sZS5zaC00MDQxICAgIFswMDVdIC4uLi4uLi4gICAxODkuODAyNzA5OiBuZXRwb2xsX3Nl
dHVwKzB4MWZlLzB4NDYwOiBfX25ldHBvbGxfc2V0dXAoKSByZXR1cm46MAogICAgICBwci9uZXRj
b24wLTQwNDUgICAgWzAwNl0gLi4uLi4xMyAgIDE4OS44MDM5NTE6IF9fYnJfZm9yd2FyZCsweDE3
Ni8weDFiMCBbYnJpZGdlXTogbmV0cG9sbF90eF9ydW5uaW5nKCkgPT0+IGJyX25ldHBvbGxfc2Vu
ZF9za2IoKQogICAgICBwci9uZXRjb24wLTQwNDUgICAgWzAwNl0gLi4uLi4xMyAgIDE4OS44MDM5
NTQ6IG5ldHBvbGxfc2VuZF9za2IrMHg3Zi8weDI1MDogbmV0cG9sbF9zdGFydF94bWl0KCkgPT0+
IHNjaGVkdWxlX2RlbGF5ZWRfd29yaygpCiAgICAgIHByL25ldGNvbjAtNDA0NSAgICBbMDA2XSAu
Li4uLjEzICAgMTg5LjgwMzk1NDogbmV0cG9sbF9zZW5kX3NrYisweDFjMS8weDI1MDogbmV0cG9s
bF9zdGFydF94bWl0KCkgPT0+IGRldl94bWl0X2NvbXBsZXRlKCkKICAgICAgcHIvbmV0Y29uMC00
MDQ1ICAgIFswMDZdIC4uLi4uMTMgICAxODkuODAzOTU3OiBfX2JyX2ZvcndhcmQrMHgxNzYvMHgx
YjAgW2JyaWRnZV06IG5ldHBvbGxfdHhfcnVubmluZygpID09PiBicl9uZXRwb2xsX3NlbmRfc2ti
KCkKICAgICAgcHIvbmV0Y29uMC00MDQ1ICAgIFswMDZdIC4uLi4uMTMgICAxODkuODAzOTU3OiBu
ZXRwb2xsX3NlbmRfc2tiKzB4N2YvMHgyNTA6IG5ldHBvbGxfc3RhcnRfeG1pdCgpID09PiBzY2hl
ZHVsZV9kZWxheWVkX3dvcmsoKQogICAgICBwci9uZXRjb24wLTQwNDUgICAgWzAwNl0gLi4uLi4x
MyAgIDE4OS44MDM5NTc6IG5ldHBvbGxfc2VuZF9za2IrMHgxYzEvMHgyNTA6IG5ldHBvbGxfc3Rh
cnRfeG1pdCgpID09PiBkZXZfeG1pdF9jb21wbGV0ZSgpCiAgICAgIHByL25ldGNvbjAtNDA0NSAg
ICBbMDA2XSAuLi4uLjEzICAgMTg5LjgwMzk1ODogX19icl9mb3J3YXJkKzB4MTc2LzB4MWIwIFti
cmlkZ2VdOiBuZXRwb2xsX3R4X3J1bm5pbmcoKSA9PT4gYnJfbmV0cG9sbF9zZW5kX3NrYigpCiAg
ICAgIHByL25ldGNvbjAtNDA0NSAgICBbMDA2XSAuLi4uLjEzICAgMTg5LjgwMzk1ODogbmV0cG9s
bF9zZW5kX3NrYisweDdmLzB4MjUwOiBuZXRwb2xsX3N0YXJ0X3htaXQoKSA9PT4gc2NoZWR1bGVf
ZGVsYXllZF93b3JrKCkKICAgICAgcHIvbmV0Y29uMC00MDQ1ICAgIFswMDZdIC4uLi4uMTMgICAx
ODkuODAzOTU5OiBuZXRwb2xsX3NlbmRfc2tiKzB4MWMxLzB4MjUwOiBuZXRwb2xsX3N0YXJ0X3ht
aXQoKSA9PT4gZGV2X3htaXRfY29tcGxldGUoKQogICAgIGt3b3JrZXIvNjoxLTEwMSAgICAgWzAw
Nl0gLi4uLi4xMyAgIDE4OS44MDM5NzA6IHF1ZXVlX3Byb2Nlc3MrMHhjMy8weDIzMDogbmV0cG9s
bF9zdGFydF94bWl0KCkgPT0+IGRldl94bWl0X2NvbXBsZXRlKCkKICAgICBrd29ya2VyLzY6MS0x
MDEgICAgIFswMDZdIC4uLi4uMTMgICAxODkuODAzOTcxOiBxdWV1ZV9wcm9jZXNzKzB4YzMvMHgy
MzA6IG5ldHBvbGxfc3RhcnRfeG1pdCgpID09PiBkZXZfeG1pdF9jb21wbGV0ZSgpCiAgICAga3dv
cmtlci82OjEtMTAxICAgICBbMDA2XSAuLi4uLjEzICAgMTg5LjgwMzk3MTogcXVldWVfcHJvY2Vz
cysweGMzLzB4MjMwOiBuZXRwb2xsX3N0YXJ0X3htaXQoKSA9PT4gZGV2X3htaXRfY29tcGxldGUo
KQogICAgICBwci9uZXRjb24wLTQwNDUgICAgWzAwMV0gLi4uLi4xMyAgIDE4OS44MDM5Nzg6IF9f
YnJfZm9yd2FyZCsweDE3Ni8weDFiMCBbYnJpZGdlXTogbmV0cG9sbF90eF9ydW5uaW5nKCkgPT0+
IGJyX25ldHBvbGxfc2VuZF9za2IoKQogICAgICBwci9uZXRjb24wLTQwNDUgICAgWzAwMV0gLi4u
Li4xMyAgIDE4OS44MDM5ODE6IG5ldHBvbGxfc2VuZF9za2IrMHg3Zi8weDI1MDogbmV0cG9sbF9z
dGFydF94bWl0KCkgPT0+IHNjaGVkdWxlX2RlbGF5ZWRfd29yaygpCiAgICAgIHByL25ldGNvbjAt
NDA0NSAgICBbMDAxXSAuLi4uLjEzICAgMTg5LjgwMzk4MTogbmV0cG9sbF9zZW5kX3NrYisweDFj
MS8weDI1MDogbmV0cG9sbF9zdGFydF94bWl0KCkgPT0+IGRldl94bWl0X2NvbXBsZXRlKCkKICAg
ICBrd29ya2VyLzE6MC0yNSAgICAgIFswMDFdIC4uLi4uMTMgICAxODkuODAzOTg2OiBxdWV1ZV9w
cm9jZXNzKzB4YzMvMHgyMzA6IG5ldHBvbGxfc3RhcnRfeG1pdCgpID09PiBkZXZfeG1pdF9jb21w
bGV0ZSgpCiAgICAgIHByL25ldGNvbjAtNDA0NSAgICBbMDA2XSAuLi4uLjEzICAgMTg5LjgwMzk4
OTogX19icl9mb3J3YXJkKzB4MTc2LzB4MWIwIFticmlkZ2VdOiBuZXRwb2xsX3R4X3J1bm5pbmco
KSA9PT4gYnJfbmV0cG9sbF9zZW5kX3NrYigpCiAgICAgIHByL25ldGNvbjAtNDA0NSAgICBbMDA2
XSAuLi4uLjEzICAgMTg5LjgwMzk5MDogbmV0cG9sbF9zZW5kX3NrYisweDdmLzB4MjUwOiBuZXRw
b2xsX3N0YXJ0X3htaXQoKSA9PT4gc2NoZWR1bGVfZGVsYXllZF93b3JrKCkKICAgICAgcHIvbmV0
Y29uMC00MDQ1ICAgIFswMDZdIC4uLi4uMTMgICAxODkuODAzOTkwOiBuZXRwb2xsX3NlbmRfc2ti
KzB4MWMxLzB4MjUwOiBuZXRwb2xsX3N0YXJ0X3htaXQoKSA9PT4gZGV2X3htaXRfY29tcGxldGUo
KQogICAgIGt3b3JrZXIvNjoxLTEwMSAgICAgWzAwNl0gLi4uLi4xMyAgIDE4OS44MDM5OTM6IHF1
ZXVlX3Byb2Nlc3MrMHhjMy8weDIzMDogbmV0cG9sbF9zdGFydF94bWl0KCkgPT0+IGRldl94bWl0
X2NvbXBsZXRlKCkKICAgICAgcHIvbmV0Y29uMC00MDQ1ICAgIFswMDFdIC4uLi4uMTMgICAxODku
ODAzOTk4OiBfX2JyX2ZvcndhcmQrMHgxNzYvMHgxYjAgW2JyaWRnZV06IG5ldHBvbGxfdHhfcnVu
bmluZygpID09PiBicl9uZXRwb2xsX3NlbmRfc2tiKCkKICAgICAgcHIvbmV0Y29uMC00MDQ1ICAg
IFswMDFdIC4uLi4uMTMgICAxODkuODA0MDAwOiBuZXRwb2xsX3NlbmRfc2tiKzB4N2YvMHgyNTA6
IG5ldHBvbGxfc3RhcnRfeG1pdCgpID09PiBzY2hlZHVsZV9kZWxheWVkX3dvcmsoKQogICAgICBw
ci9uZXRjb24wLTQwNDUgICAgWzAwMV0gLi4uLi4xMyAgIDE4OS44MDQwMDA6IG5ldHBvbGxfc2Vu
ZF9za2IrMHgxYzEvMHgyNTA6IG5ldHBvbGxfc3RhcnRfeG1pdCgpID09PiBkZXZfeG1pdF9jb21w
bGV0ZSgpCiAgICAga3dvcmtlci8xOjAtMjUgICAgICBbMDAxXSAuLi4uLjEzICAgMTg5LjgwNDAw
MzogcXVldWVfcHJvY2VzcysweGMzLzB4MjMwOiBuZXRwb2xsX3N0YXJ0X3htaXQoKSA9PT4gZGV2
X3htaXRfY29tcGxldGUoKQogICAgICBwci9uZXRjb24wLTQwNDUgICAgWzAwNl0gLi4uLi4xMyAg
IDE4OS44MDQwMDY6IF9fYnJfZm9yd2FyZCsweDE3Ni8weDFiMCBbYnJpZGdlXTogbmV0cG9sbF90
eF9ydW5uaW5nKCkgPT0+IGJyX25ldHBvbGxfc2VuZF9za2IoKQogICAgICBwci9uZXRjb24wLTQw
NDUgICAgWzAwNl0gLi4uLi4xMyAgIDE4OS44MDQwMDc6IG5ldHBvbGxfc2VuZF9za2IrMHg3Zi8w
eDI1MDogbmV0cG9sbF9zdGFydF94bWl0KCkgPT0+IHNjaGVkdWxlX2RlbGF5ZWRfd29yaygpCiAg
ICAgIHByL25ldGNvbjAtNDA0NSAgICBbMDA2XSAuLi4uLjEzICAgMTg5LjgwNDAwNzogbmV0cG9s
bF9zZW5kX3NrYisweDFjMS8weDI1MDogbmV0cG9sbF9zdGFydF94bWl0KCkgPT0+IGRldl94bWl0
X2NvbXBsZXRlKCkKICAgICBrd29ya2VyLzY6MS0xMDEgICAgIFswMDZdIC4uLi4uMTMgICAxODku
ODA0MDEwOiBxdWV1ZV9wcm9jZXNzKzB4YzMvMHgyMzA6IG5ldHBvbGxfc3RhcnRfeG1pdCgpID09
PiBkZXZfeG1pdF9jb21wbGV0ZSgpCiAgICAgIHByL25ldGNvbjAtNDA0NSAgICBbMDA2XSAuLi4u
LjEzICAgMjA2LjIyNjI5NTogX19icl9mb3J3YXJkKzB4MTc2LzB4MWIwIFticmlkZ2VdOiBuZXRw
b2xsX3R4X3J1bm5pbmcoKSA9PT4gYnJfbmV0cG9sbF9zZW5kX3NrYigpCiAgICAgIHByL25ldGNv
bjAtNDA0NSAgICBbMDA2XSAuLi4uLjEzICAgMjA2LjIyNjI5OTogbmV0cG9sbF9zZW5kX3NrYisw
eDdmLzB4MjUwOiBuZXRwb2xsX3N0YXJ0X3htaXQoKSA9PT4gc2NoZWR1bGVfZGVsYXllZF93b3Jr
KCkKICAgICAgcHIvbmV0Y29uMC00MDQ1ICAgIFswMDZdIC4uLi4uMTMgICAyMDYuMjI2Mjk5OiBu
ZXRwb2xsX3NlbmRfc2tiKzB4MWMxLzB4MjUwOiBuZXRwb2xsX3N0YXJ0X3htaXQoKSA9PT4gZGV2
X3htaXRfY29tcGxldGUoKQogICAgIGt3b3JrZXIvNjoxLTEwMSAgICAgWzAwNl0gLi4uLi4xMyAg
IDIwNi4yMjYzMDQ6IHF1ZXVlX3Byb2Nlc3MrMHhjMy8weDIzMDogbmV0cG9sbF9zdGFydF94bWl0
KCkgPT0+IGRldl94bWl0X2NvbXBsZXRlKCkK


--=-EMOGJgoEdB0ZDbEu42Hk--
